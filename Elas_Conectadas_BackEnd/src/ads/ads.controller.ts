import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  UseGuards,
} from '@nestjs/common';
import { AdsService } from './ads.service';
import { CreateAdDto } from './dtos/CreateAd.dto';
import { UpdateAdDto } from './dtos/UpdateAd.dto';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';

@Controller('ads')
export class AdsController {
  constructor(private readonly adsService: AdsService) {}

  @Post('create')
  //@UsePipes(ValidationPipe)
  createAd(@Body() createAdDto: CreateAdDto) {
    return this.adsService.createAd(createAdDto);
  }

  @Get('list')
  getAllAds() {
    return this.adsService.getAds();
  }

  @Get(':id')
  getAdById(@Param('id') id: string) { // Removido o Pipe falso!
  return this.adsService.getAdById(id);
  }

  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  patchAd(
    @Param('id') id: string, // Removido o Pipe falso!
    @Body() updateAdDto: UpdateAdDto,
  ) {
    return this.adsService.patchAd(id, updateAdDto);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  deleteAdById(@Param('id') id: string) { // Removido o Pipe falso!
    return this.adsService.deleteAd(id);
  }
}