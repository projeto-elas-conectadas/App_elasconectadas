import { IsIn, IsNotEmpty, IsOptional, IsString, IsUrl } from 'class-validator';

export class CreateAdDto {
  @IsString()
  @IsNotEmpty()
  title!: string;

  @IsString()
  @IsNotEmpty()
  content!: string;

  @IsString()
  @IsNotEmpty()
  @IsIn(['PRODUCT', 'SERVICE', 'COLLAB'])
  type!: string;

  @IsOptional()
  @IsUrl()
  cover?: string;
}
