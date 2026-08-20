import { IsIn, IsOptional, IsString, IsUrl } from 'class-validator';

export class UpdatePostDto {
  @IsOptional()
  @IsString()
  title?: string;

  @IsOptional()
  @IsString()
  content?: string;

  @IsOptional()
  @IsString()
  @IsIn(['EVENT', 'COURSE'])
  type?: string;

  @IsOptional()
  @IsUrl()
  cover?: string;
}
