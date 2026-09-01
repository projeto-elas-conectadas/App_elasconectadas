import { Test, TestingModule } from '@nestjs/testing';
import { BadRequestException } from '@nestjs/common';
import { Request } from 'express';
import { UploadController } from './upload.controller';
import { UploadService } from './upload.service';

describe('UploadController', () => {
  let controller: UploadController;

  const uploadServiceMock = {
    uploadImage: jest.fn(),
  };

  beforeEach(async () => {
    jest.clearAllMocks();
    const module: TestingModule = await Test.createTestingModule({
      controllers: [UploadController],
      providers: [{ provide: UploadService, useValue: uploadServiceMock }],
    }).compile();

    controller = module.get<UploadController>(UploadController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('devolve imageUrl no formato descrito pelo OpenAPI', async () => {
    const file = {
      fieldname: 'file',
      buffer: Buffer.from('imagem'),
    } as Express.Multer.File;
    const imageUrl = 'https://res.cloudinary.com/teste/imagem.jpg';
    uploadServiceMock.uploadImage.mockResolvedValue(imageUrl);

    await expect(
      controller.uploadImagem({ file } as Request),
    ).resolves.toEqual({ imageUrl });
    expect(uploadServiceMock.uploadImage).toHaveBeenCalledWith(file);
  });

  it('aceita o arquivo em req.files com fieldname file', async () => {
    const file = {
      fieldname: 'file',
      buffer: Buffer.from('imagem'),
    } as Express.Multer.File;
    uploadServiceMock.uploadImage.mockResolvedValue(
      'https://res.cloudinary.com/teste/imagem.jpg',
    );

    await controller.uploadImagem({ files: [file] } as Request);
    expect(uploadServiceMock.uploadImage).toHaveBeenCalledWith(file);
  });

  it('devolve 400 quando nenhum arquivo é enviado', async () => {
    await expect(controller.uploadImagem({} as Request)).rejects.toBeInstanceOf(
      BadRequestException,
    );
    expect(uploadServiceMock.uploadImage).not.toHaveBeenCalled();
  });
});
