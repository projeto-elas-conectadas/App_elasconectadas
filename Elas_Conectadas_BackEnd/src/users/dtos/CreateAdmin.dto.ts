import { CreateUserBaseDto } from './CreateUserBase.dto';

export class CreateAdminDto extends CreateUserBaseDto {
  role = 'ADMIN' as const; // Padrão automático no construtor
  constructor(data: Partial<CreateAdminDto>) {
    super();
    Object.assign(this, data);
  }
}
