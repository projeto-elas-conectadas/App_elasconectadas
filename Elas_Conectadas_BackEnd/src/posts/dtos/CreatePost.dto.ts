import { PostType } from '@prisma/client';
import { IsEnum, IsNotEmpty, IsString } from 'class-validator';

export class CreatePostDto {
  @IsString()
  @IsNotEmpty()
  title: string;

  cover?: string;

  @IsString()
  @IsNotEmpty()
  content: string;

  @IsEnum(PostType)
  @IsNotEmpty()
  type: PostType;

  constructor(data: Partial<CreatePostDto>) {
    Object.assign(this, data);
  }
}
