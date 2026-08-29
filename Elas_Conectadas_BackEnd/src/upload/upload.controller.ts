import {
  BadRequestException,
  Controller,
  HttpCode,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { UploadService } from './upload.service';

@Controller('upload')
export class UploadController {
  constructor(private readonly uploadService: UploadService) {}

  @Post('imagem')
  @HttpCode(201)
  @UseInterceptors(FileInterceptor('file'))
  async uploadImagem(@UploadedFile() file: Express.Multer.File) {
    if (!file) {
      throw new BadRequestException('Selecione uma imagem para enviar');
    }

    const url = await this.uploadService.uploadImage(file);
    return { imageUrl: url };
  }
}
