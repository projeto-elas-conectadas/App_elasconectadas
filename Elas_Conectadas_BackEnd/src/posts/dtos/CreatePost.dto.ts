import { IsIn, IsNotEmpty, IsOptional, IsString, IsUrl } from 'class-validator';

export class CreatePostDto {
  @IsString()
  @IsNotEmpty()
  title!: string;

  @IsString()
  @IsNotEmpty()
  content!: string;

  @IsString()
  @IsNotEmpty()
  @IsIn(['EVENT', 'COURSE'])
  type!: string;

  @IsOptional()
  @IsUrl()
  cover?: string;
}
