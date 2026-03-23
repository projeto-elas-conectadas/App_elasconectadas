import { IsEmail, IsString } from 'class-validator';

export class requestTokenDto {
  @IsString()
  @IsEmail()
  email: string;
}
