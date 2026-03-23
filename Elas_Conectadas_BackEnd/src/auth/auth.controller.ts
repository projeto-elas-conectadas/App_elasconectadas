import { Body, Controller, NotFoundException, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { sendEmailDto } from './dtos/email.dto';
import { requestTokenDto } from './dtos/requestToken.dto';
import { UsersService } from 'src/users/users.service';
import { VerifyOtpDto } from './dtos/verifyOtp.dto';

@Controller('auth')
export class AuthController {
  constructor(
    readonly authService: AuthService,
    readonly usersService: UsersService,
  ) {}

  @Post('login')
  async login(@Body() body: { email: string; password: string; otp?: string }) {
    return this.authService.login(body.email, body.password, body.otp);
  }

  @Post('send')
  async sendMail(@Body() dto: sendEmailDto) {
    await this.authService.sendEmail(dto);
    return { message: 'Email enviado com sucesso!' };
  }

  @Post('request-otp')
  async requestOTP(@Body() dto: requestTokenDto) {
    const { email } = dto;
    const user = await this.authService.getUserByEmail(email);

    if (!user) {
      throw new NotFoundException('Usuário não encontrado');
    }

    //Enviando um novo email com o código de verificação
    await this.usersService.emailVerification(user);

    return {
      message: 'Novo código de verificação enviado para o e-mail de cadastro',
    };
  }

  @Post('verify-otp')
  async verifyOTP(@Body() dto: VerifyOtpDto) {
    const { email, otp } = dto;

    // Busca o usuário pelo email
    const user = await this.authService.getUserByEmail(email);
    if (!user) throw new NotFoundException('Usuário não encontrado');

    // Só permite verificação se a conta estiver UNVERIFIED
    if (user.accountStatus !== 'UNVERIFIED') {
      return { message: 'Conta já verificada' };
    }

    // Valida OTP e atualiza status
    await this.authService.verifyToken(user.id, otp);

    return { message: 'Conta verificada com sucesso!' };
  }
}
