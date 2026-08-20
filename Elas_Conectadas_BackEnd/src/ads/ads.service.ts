import { HttpException, Injectable } from '@nestjs/common';
import { AdType } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreateAdDto } from './dtos/CreateAd.dto';
import { UpdateAdDto } from './dtos/UpdateAd.dto';

@Injectable()
export class AdsService {
  constructor(private prisma: PrismaService) {}

  createAd(data: CreateAdDto) {
    return this.prisma.ads.create({
      data: {
        title: data.title,
        content: data.content,
        type: data.type as AdType,
        cover: data.cover,
      },
    });
  }

  getAds() {
    return this.prisma.ads.findMany();
  }

  getAdById(id: string) {
    return this.prisma.ads.findUnique({
      where: { id },
    });
  }

  async patchAd(id: string, data: UpdateAdDto) {
    const findAd = await this.getAdById(id);
    if (!findAd) throw new HttpException('Post Not Found', 404);

    return this.prisma.ads.update({
      where: { id },
      data: {
        title: data.title,
        content: data.content,
        type: data.type as AdType | undefined,
        cover: data.cover,
      },
    });
  }

  async deleteAd(id: string) {
    const findAd = await this.getAdById(id);
    if (!findAd) throw new HttpException('Post Not Found', 404);
    return this.prisma.ads.delete({ where: { id } });
  }
}
