import { IsIn, IsOptional, IsString, IsUrl } from 'class-validator';

export class UpdateAdDto {
  @IsOptional()
  @IsString()
  title?: string;

  @IsOptional()
  @IsString()
  content?: string;

  @IsOptional()
  @IsString()
  @IsIn(['PRODUCT', 'SERVICE', 'COLLAB'])
  type?: string;

  @IsOptional()
  @IsUrl()
  cover?: string;
}
