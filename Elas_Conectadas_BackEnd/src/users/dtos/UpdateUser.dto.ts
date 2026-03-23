import { IsNotEmpty, IsString } from 'class-validator';

export class UpdateUserDto {
  @IsString()
  @IsNotEmpty()
  email?: string;

  @IsString()
  @IsNotEmpty()
  password?: string;

  @IsString()
  @IsNotEmpty()
  name?: string;

  @IsString()
  @IsNotEmpty()
  phone?: string;

  @IsString()
  @IsNotEmpty()
  dob?: string;

  @IsString()
  occupation?: string;

  @IsString()
  location?: string;

  @IsString()
  bio?: string;

  pfp?: Buffer;

  constructor(data: Partial<UpdateUserDto>) {
    Object.assign(this, data);
  }
}
