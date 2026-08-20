import {
  BadRequestException,
  forwardRef,
  Inject,
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { UsersService } from '../users/users.service';
import * as nodemailer from 'nodemailer';
import { ConfigService } from '@nestjs/config';
import { sendEmailDto } from './dtos/email.dto';
import { LoginDto } from './dtos/login.dto';
import { requestTokenDto } from './dtos/requestToken.dto';
import { VerifyOtpDto } from './dtos/verifyOtp.dto';
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
  ) {}

  async login(dto: LoginDto) {
    const user = await this.usersService.validateUser(dto.email, dto.password);
    if (!user) throw new UnauthorizedException('Credenciais inválidas');

    const payload = { sub: user.id, email: user.email };
    const access_token = this.jwtService.sign(payload);

    delete (user as { password?: string }).password;
    delete (user as { phone?: string }).phone;
    delete (user as { dob?: string }).dob;

    const safeUser: Record<string, unknown> = {};
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

  async sendMail(dto: sendEmailDto) {
    await this.deliverEmail({
      to: dto.email,
      subject: 'Elas Conectadas',
      html: 'Mensagem enviada pela plataforma Elas Conectadas.',
    });
  }

  async requestOTP(dto: requestTokenDto) {
    const user = await this.getUserByEmail(dto.email);
    if (!user) {
      throw new NotFoundException('Usuário não encontrado');
    }

    await this.usersService.emailVerification(user);
  }

  async verifyOTP(dto: VerifyOtpDto) {
    const user = await this.getUserByEmail(dto.email);
    if (!user) {
      throw new NotFoundException('Usuário não encontrado');
    }

    await this.verifyToken(user.id, dto.otp);
  }

  private emailTransport() {
    const host = this.configService.get<string>('EMAIL_HOST');
    const port = this.configService.get<number>('PORT');
    const user = this.configService.get<string>('EMAIL_USER');
    const pass = this.configService.get<string>('EMAIL_PASSWORD');
    const secure = this.configService.get<boolean>('SMTP_SECURE') ?? false;

    return nodemailer.createTransport({
      host: host,
      port: port as unknown as number,
      secure: secure,
      auth: {
        user: user,
        pass: pass,
      },
    });
  }

  async deliverEmail(options: {
    to: string;
    subject: string;
    html: string;
  }) {
    const transport = this.emailTransport();

    const mailOptions: nodemailer.SendMailOptions = {
      from: this.configService.get<string>('EMAIL_USER'),
      to: options.to,
      subject: options.subject,
      html: options.html,
    };

    await transport.sendMail(mailOptions);
  }

  async generateOTP(userId: string): Promise<{ userId: string; otp: string }> {
    const otp = crypto.randomInt(100000, 999999).toString();
    const hashedOTP = await bcrypt.hash(otp, 12);
    const now = new Date();
    const expiresAt = new Date(now.getTime() + 5 * 60 * 1000);

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

  async validateOTP(userId: string, token: string): Promise<boolean> {
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

    const isMatch = await bcrypt.compare(token, validToken.token);

    if (!isMatch) {
      throw new BadRequestException(
        'Código de verificação inválido. Por favor, tente novamente.',
      );
    }

    return true;
  }

  async verifyToken(userId: string, token: string) {
    await this.validateOTP(userId, token);

    return this.prisma.user.update({
      where: { id: userId },
      data: { accountStatus: 'VERIFIED' },
    });
  }

  async getUserByEmail(email: string) {
    return this.prisma.user.findUnique({ where: { email } });
  }
}
