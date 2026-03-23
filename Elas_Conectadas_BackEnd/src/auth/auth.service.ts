import {
  BadRequestException,
  forwardRef,
  Inject,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';
import * as nodemailer from 'nodemailer';
import { ConfigService } from '@nestjs/config';
import { sendEmailDto } from './dtos/email.dto';
import * as crypto from 'crypto';
import * as bcrypt from 'bcrypt';
import { OTPType } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class AuthService {
  constructor(
    @Inject(forwardRef(() => UsersService))
    private usersService: UsersService,
    private jwtService: JwtService,
    private readonly configService: ConfigService,
    private prisma: PrismaService,
  ) { }

  async login(email: string, password: string, otp?: string) {
    // Verifica se as credenciais enviadas na requisição são válidas (email e password)
    const user = await this.usersService.validateUser(email, password);
    if (!user) throw new UnauthorizedException('Credenciais inválidas');
    // O JWT não serve apenas para autenticação, ela também carrega uma assinatura incorporada pelo
    // payload que contém informações não sensíveis do usuário. Quando descriptografado as rotas podem
    // fazer uso destes dados.

    // Checa o status da conta
    if (user.accountStatus === 'UNVERIFIED') {
      if (!otp) {
        throw new UnauthorizedException(
          'Sua conta não está verificada, por favor forneça o código de verificação!',
        );
      }

      const otpRecord = await this.prisma.oTP.findFirst({
        where: {
          userId: user.id,
          expiresAt: { gte: new Date() },
        },
        orderBy: { createAt: 'desc' },
      });

      if (!otpRecord || !(await bcrypt.compare(otp, otpRecord.token))) {
        throw new UnauthorizedException(
          'Código de verificação inválido ou expirado. Por favor, forneça um código recente para a verificação da sua conta',
        );
      }

      await this.verifyToken(user.id, otp);
    }

    const payload = { sub: user.id, email: user.email };
    const access_token = this.jwtService.sign(payload);

    // Remove campos sensíveis antes de retornar o objeto
    delete (user as { password?: string }).password;
    delete (user as { phone?: string }).phone;
    delete (user as { dob?: string }).dob;

    //Cria um objeto apenas com campos definidos (sem nulos ou undefined)
    const safeUser: Record<string, any> = {};
    Object.entries(user).forEach(([key, value]) => {
      if (value !== null && value !== undefined) {
        safeUser[key] = value;
      }
    });

    return {
      access_token,
      user: safeUser,
    };
  }

  emailTransport() {
    const host = this.configService.get<string>('EMAIL_HOST');
    const port = this.configService.get<number>('PORT');
    const user = this.configService.get<string>('EMAIL_USER');
    const pass = this.configService.get<string>('EMAIL_PASSWORD');
    const secure = this.configService.get<boolean>('SMTP_SECURE') ?? false;

    const transporter = nodemailer.createTransport({
      host: host,
      port: port as unknown as number,
      secure: secure,
      auth: {
        user: user,
        pass: pass,
      },
    });

    return transporter;
  }

  async sendEmail(dto: sendEmailDto) {
    const { recipients, subject, html } = dto;

    const transport = this.emailTransport();

    const host = this.configService.get<string>('EMAIL_HOST');
    const port = this.configService.get<number>('PORT');
    const user = this.configService.get<string>('EMAIL_USER');
    const secure = this.configService.get<boolean>('SMTP_SECURE') ?? false;

    console.log('📨 Tentando enviar email com as seguintes configurações:');
    console.log({ host, port, user, secure, recipients, subject });

    const options: nodemailer.sendMailOptions = {
      from: this.configService.get<string>('EMAIL_USER'),
      to: recipients,
      subject: subject,
      html: html,
    };

    try {
      const result = await transport.sendMail(options);
      console.log('✅ E-mail enviado com sucesso!');
      console.log('📤 Resultado do envio:', result);
    } catch (error) {
      console.log(`Erro ao enviar o e-mail: ${error}`);
    }
  }

  async generateOTP(userId: number): Promise<{ userId: number; otp: string }> {
    const otp = crypto.randomInt(100000, 999999).toString();
    const hashedOTP = await bcrypt.hash(otp, 12);
    const now = new Date();
    const expiresAt = new Date(now.getTime() + 5 * 60 * 1000);

    //Checando se OTP já existe para o usuário em questão
    const existingOTP = await this.prisma.oTP.findFirst({
      where: {
        userId: userId,
        expiresAt: { gte: new Date() },
      },
      orderBy: { createAt: 'desc' },
    });

    if (existingOTP) {
      await this.prisma.oTP.update({
        where: { id: existingOTP.id },
        data: {
          token: hashedOTP,
          expiresAt: expiresAt,
          createAt: new Date(),
        },
      });
    } else {
      await this.prisma.oTP.create({
        data: {
          userId,
          token: hashedOTP,
          type: OTPType.OTP,
          expiresAt,
          createAt: new Date(),
        },
      });
    }

    return { userId, otp };
  }

  async validateOTP(userId: number, token: string): Promise<boolean> {
    // Checa o status da conta
    const validToken = await this.prisma.oTP.findFirst({
      where: {
        userId: userId,
        expiresAt: { gte: new Date() },
      },
      orderBy: { createAt: 'desc' },
    });

    if (!validToken) {
      throw new BadRequestException(
        'Código de verificação expirado, solicite um novo',
      );
    }

    console.log('OTP fornecido:', token);
    console.log('Hash armazenado:', validToken.token);

    const isMatch = await bcrypt.compare(token, validToken.token);
    console.log('Combina?', isMatch);

    if (!isMatch) {
      throw new BadRequestException(
        'Código de verificação inválido. Por favor, tente novamente.',
      );
    }

    return true;
  }

  async verifyToken(userId: number, token: string) {
    await this.validateOTP(userId, token);

    const user = await this.prisma.user.update({
      where: { id: userId },
      data: { accountStatus: 'VERIFIED' },
    });

    return user;
  }

  async getUserByEmail(email: string) {
    return this.prisma.user.findUnique({ where: { email } });
  }
}
