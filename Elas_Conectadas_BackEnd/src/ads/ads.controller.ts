import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Param,
  Patch,
  Post,
} from '@nestjs/common';
import { AdsService } from './ads.service';
import { CreateAdDto } from './dtos/CreateAd.dto';
import { UpdateAdDto } from './dtos/UpdateAd.dto';

@Controller('ads')
export class AdsController {
  constructor(private readonly adsService: AdsService) {}

  @Post('create')
  @HttpCode(201)
  createAd(@Body() createAdDto: CreateAdDto) {
    return this.adsService.createAd(createAdDto);
  }

  @Get('list')
  getAllAds() {
    return this.adsService.getAds();
  }

  @Get(':id')
  getAdById(@Param('id') id: string) {
    return this.adsService.getAdById(id);
  }

  @Patch(':id')
  patchAd(@Param('id') id: string, @Body() updateAdDto: UpdateAdDto) {
    return this.adsService.patchAd(id, updateAdDto);
  }

  @Delete(':id')
  deleteAdById(@Param('id') id: string) {
    return this.adsService.deleteAd(id);
  }
}
