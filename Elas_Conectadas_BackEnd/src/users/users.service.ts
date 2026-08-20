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
import { CreateAdminDto } from './dtos/CreateAdmin.dto';
import { CreateUserDto } from './dtos/CreateUser.dto';
import { UpdateUserDto } from './dtos/UpdateUser.dto';

@Injectable()
export class UsersService {
  constructor(
    private prisma: PrismaService,
    @Inject(forwardRef(() => AuthService))
    private authService: AuthService,
  ) {}

  async createUser(
    data: CreateUserDto | CreateAdminDto,
    role: 'USER' | 'ADMIN',
  ) {
    const existingUser = await this.prisma.user.findUnique({
      where: { email: data.email },
    });
    if (existingUser) {
      throw new HttpException('Este endereço de email já está cadastrado', 400);
    }

    const hashedPassword = await bcrypt.hash(data.password, 12);

    const userData: Prisma.UserCreateInput = {
      email: data.email,
      password: hashedPassword,
      name: data.name,
      role,
    };

    if ('phone' in data && data.phone) {
      userData.phone = data.phone;
    }
    if ('dob' in data && data.dob) {
      userData.dob = data.dob;
    }

    const newUser = await this.prisma.user.create({
      data: userData,
    });

    await this.emailVerification(newUser);

    const { password: _, ...safeUser } = newUser;
    return safeUser;
  }

  async emailVerification(user: User) {
    const otpData = await this.authService.generateOTP(user.id);

    await this.authService.deliverEmail({
      to: user.email,
      subject: 'Confirmação do seu registro de conta',
      html: `Seu código de verificação é: <strong>${otpData.otp}</strong>.
      <br />Forneça esse código dentro do aplicativo para verificar sua conta. 
      <br />Atenciosamente, equipe do Elas conectadas.`,
    });

    return otpData.otp;
  }

  async validateUser(email: string, password: string): Promise<User | null> {
    const user = await this.prisma.user.findUnique({ where: { email } });

    if (!user) {
      throw new UnauthorizedException('Credenciais inválidas');
    }

    const passwordMatch = await bcrypt.compare(password, user.password);

    if (!passwordMatch) {
      throw new UnauthorizedException('Credenciais inválidas');
    }

    return user;
  }

  getUsers() {
    return this.prisma.user.findMany();
  }

  getUserById(id: string) {
    return this.prisma.user.findUnique({ where: { id } });
  }

  async updateUser(id: string, data: UpdateUserDto) {
    const findUser = await this.getUserById(id);
    if (!findUser) throw new HttpException('Usuário não encontrado', 404);

    return this.prisma.user.update({
      where: { id },
      data: {
        name: data.name,
        phone: data.phone,
        occupation: data.occupation,
        bio: data.bio,
        pfp: data.pfp,
        rua: data.rua,
        numero: data.numero,
        bairro: data.bairro,
        cidade: data.cidade,
        estado: data.estado,
      },
    });
  }

  async deleteUser(id: string) {
    const findUser = await this.getUserById(id);
    if (!findUser) throw new HttpException('User not found', 404);
    return this.prisma.user.delete({ where: { id } });
  }
}
