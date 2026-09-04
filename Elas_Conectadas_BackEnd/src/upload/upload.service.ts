import { Injectable, InternalServerErrorException } from '@nestjs/common';
import { v2 as cloudinary } from 'cloudinary';
import * as streamifier from 'streamifier';

@Injectable()
export class UploadService {
  constructor() {
    cloudinary.config({
      cloud_name: process.env.CLOUDINARY_CLOUD_NAME,
      api_key: process.env.CLOUDINARY_API_KEY,
      api_secret: process.env.CLOUDINARY_API_SECRET,
    });
  }

  // Recebe o arquivo e manda para a nuvem
  async uploadImage(file: Express.Multer.File): Promise<string> {
    try {
      return await this.uploadOnce(file);
    } catch (error) {
      if (!this.isTransientNetworkError(error)) {
        throw this.wrapUploadError(error);
      }

      await new Promise((resolve) => setTimeout(resolve, 400));

      try {
        return await this.uploadOnce(file);
      } catch (retryError) {
        throw this.wrapUploadError(retryError);
      }
    }
  }

  private uploadOnce(file: Express.Multer.File): Promise<string> {
    return new Promise((resolve, reject) => {
      const uploadStream = cloudinary.uploader.upload_stream(
        { folder: 'elas-conectadas' },
        (error, result) => {
          if (error) {
            return reject(error);
          }

          if (result && result.secure_url) {
            resolve(result.secure_url);
          } else {
            reject(
              new InternalServerErrorException(
                'Falha no upload: Cloudinary não retornou a URL',
              ),
            );
          }
        },
      );

      streamifier.createReadStream(file.buffer).pipe(uploadStream);
    });
  }

  private isTransientNetworkError(error: unknown): boolean {
    const text = this.stringifyError(error);
    return (
      text.includes('EAI_AGAIN') ||
      text.includes('ENETUNREACH') ||
      text.includes('ECONNRESET') ||
      text.includes('ETIMEDOUT')
    );
  }

  private wrapUploadError(error: unknown): InternalServerErrorException {
    if (error instanceof InternalServerErrorException) {
      return error;
    }

    const text = this.stringifyError(error);
    if (this.isTransientNetworkError(error)) {
      return new InternalServerErrorException(
        'Não foi possível enviar a imagem (falha de rede/DNS). Tente novamente.',
      );
    }

    return new InternalServerErrorException(
      text || 'Falha ao enviar a imagem para o Cloudinary',
    );
  }

  private stringifyError(error: unknown): string {
    if (error instanceof Error) {
      return error.message;
    }
    if (typeof error === 'object' && error !== null && 'message' in error) {
      return String((error as { message: unknown }).message);
    }
    return String(error ?? '');
  }
}
