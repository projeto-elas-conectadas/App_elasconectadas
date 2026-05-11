import { PostType } from '@prisma/client';
import { IsEnum, IsString } from 'class-validator';

export class UpdatePostDto {
  @IsString()
  title?: string;

  cover?: string;

  @IsString()
  content?: string;

  @IsEnum(PostType)
  type?: PostType;

  constructor(data: Partial<UpdatePostDto>) {
    Object.assign(this, data);
  }
}
