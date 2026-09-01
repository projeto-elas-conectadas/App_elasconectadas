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
  uploadImage(file: Express.Multer.File): Promise<string> {
    return new Promise((resolve, reject) => {
      const uploadStream = cloudinary.uploader.upload_stream(
        { folder: 'elas-conectadas' },
        (error, result) => {
          if (error) {
            return reject(
              new InternalServerErrorException(
                error.message || 'Falha ao enviar a imagem para o Cloudinary',
              ),
            );
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
}