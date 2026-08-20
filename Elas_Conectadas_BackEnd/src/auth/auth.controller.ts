import { Body, Controller, HttpCode, Post } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dtos/login.dto';
import { sendEmailDto } from './dtos/email.dto';
import { requestTokenDto } from './dtos/requestToken.dto';
import { VerifyOtpDto } from './dtos/verifyOtp.dto';

@Controller()
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('login')
  @HttpCode(201)
  login(@Body() dto: LoginDto) {
    return this.authService.login(dto);
  }

  @Post('send')
  @HttpCode(201)
  sendMail(@Body() dto: sendEmailDto) {
    return this.authService.sendMail(dto);
  }

  @Post('request-otp')
  @HttpCode(201)
  requestOTP(@Body() dto: requestTokenDto) {
    return this.authService.requestOTP(dto);
  }

  @Post('verify-otp')
  @HttpCode(201)
  verifyOTP(@Body() dto: VerifyOtpDto) {
    return this.authService.verifyOTP(dto);
  }
}
