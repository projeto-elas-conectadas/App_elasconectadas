import {
  BadRequestException,
  Controller,
  HttpCode,
  Post,
  Req,
} from '@nestjs/common';
import { Request } from 'express';
import { UploadService } from './upload.service';

type RequestComUpload = Request & {
  file?: Express.Multer.File;
  files?: Express.Multer.File[] | Record<string, Express.Multer.File[]>;
};

@Controller('upload')
export class UploadController {
  constructor(private readonly uploadService: UploadService) {}

  @Post('imagem')
  @HttpCode(201)
  async uploadImagem(@Req() req: Request) {
    const file = this.arquivoDoRequest(req);
    if (!file) {
      throw new BadRequestException('Selecione uma imagem para enviar');
    }

    const url = await this.uploadService.uploadImage(file);
    return { imageUrl: url };
  }

  private arquivoDoRequest(req: Request): Express.Multer.File | undefined {
    const comUpload = req as RequestComUpload;

    if (comUpload.file?.buffer) {
      return comUpload.file;
    }

    const files = comUpload.files;
    if (Array.isArray(files)) {
      return files.find((item) => item.fieldname === 'file') ?? files[0];
    }
    if (files?.file?.[0]) {
      return files.file[0];
    }
    return undefined;
  }
}
