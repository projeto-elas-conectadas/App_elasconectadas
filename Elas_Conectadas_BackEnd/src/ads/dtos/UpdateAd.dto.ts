import { IsNotEmpty, IsString } from 'class-validator';

export class UpdateAdDto {
  @IsString()
  @IsNotEmpty()
  title?: string;

  @IsNotEmpty()
  cover?: string;

  @IsNotEmpty()
  content?: string;

  constructor(data: Partial<UpdateAdDto>) {
    Object.assign(this, data);
  }
}
