import { IsNotEmpty, IsString } from 'class-validator';
import { CreateUserBaseDto } from './CreateUserBase.dto';

export class CreateUserDto extends CreateUserBaseDto {
  @IsString()
  @IsNotEmpty()
  phone!: string;

  @IsString()
  @IsNotEmpty()
  dob!: string;
}
