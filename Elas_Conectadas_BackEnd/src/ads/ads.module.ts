import { Module } from '@nestjs/common';
import { PrismaModule } from 'src/prisma/prisma.module';
import { AdsController } from './ads.controller';
import { AdsService } from './ads.service';

@Module({
  imports: [PrismaModule],
  providers: [AdsService],
  controllers: [AdsController],
})
export class AdsModule {}
