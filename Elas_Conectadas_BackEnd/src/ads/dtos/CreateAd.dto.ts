import { AdType } from '@prisma/client';
import { IsEnum, IsNotEmpty, IsString } from 'class-validator';

export class CreateAdDto {
  @IsString()
  @IsNotEmpty()
  title: string;

  cover?: Buffer;

  @IsString()
  @IsNotEmpty()
  content: string;

  @IsEnum(AdType)
  @IsNotEmpty()
  type: AdType;

  constructor(data: Partial<CreateAdDto>) {
    Object.assign(this, data);
  }
}
