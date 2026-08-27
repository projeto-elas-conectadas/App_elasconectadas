import {
  BadRequestException,
  Controller,
  Post,
  UploadedFile,
  UseInterceptors,
} from '@nestjs/common';
import { FileInterceptor } from '@nestjs/platform-express';
import { UploadService } from './upload.service';
import { ApiConsumes, ApiBody, ApiTags } from '@nestjs/swagger';

@ApiTags('Uploads')
@Controller('upload')
export class UploadController {
  constructor(private readonly uploadService: UploadService) {}

  @Post('imagem')
  @UseInterceptors(FileInterceptor('file')) // "file" é o nome do campo que o Flutter vai mandar
  @ApiConsumes('multipart/form-data') // Avisa o Swagger que é um upload de arquivo
  @ApiBody({
    schema: {
      type: 'object',
      required: ['file'],
      properties: {
        file: {
          type: 'string',
          format: 'binary', // Cria aquele botão de "Escolher Arquivo" no Swagger
        },
      },
    },
  })
  async uploadImagem(@UploadedFile() file: Express.Multer.File) {
    if (!file) {
      throw new BadRequestException('Selecione uma imagem para enviar');
    }

    // Manda para o serviço e pega a URL de volta
    const url = await this.uploadService.uploadImage(file);

    // Responde pro Flutter com a URL
    return { imageUrl: url };
  }
}
