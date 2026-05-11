import { IsNotEmpty, IsString, IsOptional, IsBoolean, IsUrl } from 'class-validator';

export class UpdateUserDto {
  @IsString()
  @IsNotEmpty()
  @IsOptional() // Adicionado: permite que o frontend não envie o email se não for alterar
  email?: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  password?: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  name?: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  phone?: string;

  @IsString()
  @IsNotEmpty()
  @IsOptional()
  dob?: string;

  @IsString()
  @IsOptional() // Faltava a validação aqui
  occupation?: string;

  @IsString()
  @IsOptional()
  rua?: string;

  @IsString()
  @IsOptional()
  numero?: string;

  @IsString()
  @IsOptional()
  bairro?: string;

  @IsString()
  @IsOptional()
  cidade?: string;

  @IsString()
  @IsOptional()
  estado?: string;
  
  @IsString()
  @IsOptional() // Faltava a validação aqui
  bio?: string;

  // --- MUDANÇA DA FOTO (CLOUDINARY) ---
  @IsUrl({}, { message: 'A foto de perfil deve ser um link válido do Cloudinary' })
  @IsString()
  @IsOptional()
  pfp?: string; // Mudou de Buffer para string!

  @IsBoolean()
  @IsOptional()
  emailVerificado?: boolean;

  constructor(data: Partial<UpdateUserDto>) {
    Object.assign(this, data);
  }
}