import { IsEmail, IsNotEmpty } from 'class-validator';

export class requestTokenDto {
  @IsEmail()
  @IsNotEmpty()
  email!: string;
}
