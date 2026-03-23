import { Injectable } from '@nestjs/common';
import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { ConfigService } from '@nestjs/config';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy) {
  constructor(config: ConfigService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      ignoreExpiration: false,
      secretOrKey: config.getOrThrow('JWT_SECRET'), // Use a variável de ambiente em produção
      usernameField: 'email',
      passwordField: 'password',
    });
  }
  // Retorna um objeto simplificado contendo userId e email
  async validate(payload: any) {
    return { userId: payload.sub, email: payload.email };
  }
  // A classe PassportStrategy espera que sejam passadas para ela no construtor campos
  // de nome usernameField e passwordField como usamos login = email e senha = password
  // precisamos sobrescrever essa configuração.

  // async validate(email: string, password: string): Promise<any> {
  //   const user = await this.authService.validateUserByEmail(email, password);
  //   if (!user) {
  //     throw new UnauthorizedException();
  //   }
  //   return user;
  // }
}
