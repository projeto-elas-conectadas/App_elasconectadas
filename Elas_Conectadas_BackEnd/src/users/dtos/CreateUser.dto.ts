import { UserType } from '@prisma/client';
import { IsNotEmpty, IsString } from 'class-validator';
import { IsAdult } from './AgeConstraint';
import { CreateUserBaseDto } from './CreateUserBase.dto';

export class CreateUserDto extends CreateUserBaseDto {
  @IsString()
  @IsNotEmpty()
  phone: string;

  @IsString()
  @IsNotEmpty()
  @IsAdult({
    message:
      'O usuário deve ter pelo menos 18 anos de idade e fornecer uma data válida (DD/MM/AAAA).',
  })
  dob: string;

  role: UserType;

  //role: 'USER' = 'USER'; // Padrão automático no construtor

  constructor(data: Partial<CreateUserDto>) {
    super();
    Object.assign(this, data);
  }
}
