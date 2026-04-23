import { HttpException, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class AdsService {
  constructor(private prisma: PrismaService) {}

  //cria um anuncio
  createAd(data: Prisma.AdsCreateInput) {
    return this.prisma.ads.create({
      data: { ...data },
    });
  }

  //retorna todos os anuncios
  getAds() {
    return this.prisma.ads.findMany();
  }

  //retorna um anuncio por id
  getAdById(id: string) {
    return this.prisma.ads.findUnique({
      where: { id },
    });
  }

  //atualiza parcialmente um anuncio por id
  async patchAd(id: string, data: Prisma.AdsUpdateInput) {
    const findAd = await this.getAdById(id);
    if (!findAd) throw new HttpException('Post Not Found', 404);

    return this.prisma.ads.update({
      where: { id },
      data: { ...data },
    });
  }

  //deleta um anuncio por id
  async deleteAd(id: string) {
    const findAd = await this.getAdById(id);
    if (!findAd) throw new HttpException('Post Not Found', 404);
    return this.prisma.ads.delete({ where: { id } });
  }
}
