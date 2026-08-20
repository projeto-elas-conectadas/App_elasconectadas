import { IsEmail, IsNotEmpty } from 'class-validator';

export class sendEmailDto {
  @IsEmail()
  @IsNotEmpty()
  email!: string;
}
