import { IsNotEmpty, IsOptional, IsString, IsUrl } from 'class-validator';
import { CreateUserBaseDto } from './CreateUserBase.dto';

export class CreateUserDto extends CreateUserBaseDto {
  @IsString()
  @IsNotEmpty()
  phone!: string;

  @IsString()
  @IsNotEmpty()
  dob!: string;

  @IsOptional()
  @IsUrl()
  pfp?: string;
}
