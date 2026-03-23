/* eslint-disable @typescript-eslint/no-unused-vars */
import {
  forwardRef,
  HttpException,
  Inject,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';

import { Prisma, User } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { PrismaService } from '../prisma/prisma.service';
import { AuthService } from 'src/auth/auth.service';

@Injectable()
export class UsersService {
  constructor(
    private prisma: PrismaService,
    @Inject(forwardRef(() => AuthService))
    private authService: AuthService,
  ) {}

  //registra um novo usuário
  async createUser(data: Prisma.UserCreateInput, role: 'USER' | 'ADMIN') {
    //Verifica que já existe um registro com este endereço de email
    const existingUser = await this.prisma.user.findUnique({
      where: { email: data.email },
    });
    if (existingUser) {
      throw new HttpException('Este endereço de email já está cadastrado', 400);
    }

    const hashedPassword = await bcrypt.hash(data.password, 12);

    const newUser = await this.prisma.user.create({
      data: { ...data, password: hashedPassword, role },
    });
    //Envia um email com o código de confirmação no email do usuário
    await this.emailVerification(newUser);
    // Remove a senha do objeto newUSer e criando um novo objeto chamado de safeUser
    // Esse então é retornado.
    const { password: _, ...safeUser } = newUser;
    //return safeUser;

    return safeUser;
  }

  async emailVerification(user: User) {
    const otpData = await this.authService.generateOTP(user.id);
    const otp = otpData.otp;

    const emailDto = {
      recipients: [user.email],
      subject: 'Confirmação do seu registro de conta',
      html: `Seu código de verificação é: <strong>${otpData.otp}</strong>.
      <br />Forneça esse código dentro do aplicativo para verificar sua conta. 
      <br />Atenciosamente, equipe do Elas conectadas.`,
    };

    await this.authService.sendEmail(emailDto);
    return otp;
  }

  // faz a validação do usuário
  // Se trata de uma função assíncrona chamada de validateUser usada para validar se o usuário está cadastrado.
  // Pode retornar um dado do tipo User ou null (Promise<User | null> )
  async validateUser(email: string, password: string): Promise<User | null> {
    // Faz uso do cliente prisma para buscar no banco de dados utilizado, um registro com o email fornecido.
    // A propriedade where recebe uma variável ou parâmetro com os dados de um campo que é único na tabela (@unique).
    const user = await this.prisma.user.findUnique({ where: { email } });

    if (!user) {
      throw new UnauthorizedException('Credenciais inválidas');
    }

    // Se a consulta com findUnique retornar um usuário (e não um null) e a comparação da senha de entrada for compátivel
    // com a senha hash armazenada então retorna os dados do usuário.
    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      throw new UnauthorizedException('Credenciais inválidas');
    }

    return user;
  }

  //retorna todos os usuários
  getUsers() {
    return this.prisma.user.findMany();
  }

  //retorna um usuário por id
  getUserById(id: number) {
    return this.prisma.user.findUnique({ where: { id } });
  }

  //atualiza os dados de um usuário por id
  async updateUser(id: number, data: Prisma.UserUpdateInput) {
    const findUser = await this.getUserById(id);
    if (!findUser) throw new HttpException('Usuário não encontrado', 404);

    if (data.email && data.email !== findUser.email) {
      const existingEmail = await this.prisma.user.findUnique({
        where: { email: data.email as string },
      });
      if (existingEmail)
        throw new HttpException('Este email já está em uso', 400);
    }
    return this.prisma.user.update({ where: { id }, data });
  }

  //remove o usuário do banco de dados
  async deleteUser(id: number) {
    const findUser = await this.getUserById(id);
    if (!findUser) throw new HttpException('User not found', 404);
    return this.prisma.user.delete({ where: { id } });
  }
}
