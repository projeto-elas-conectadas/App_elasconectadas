import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { PostsModule } from './posts/posts.module';
import { PrismaModule } from './prisma/prisma.module';
import { UsersModule } from './users/users.module';
import { UsersService } from './users/users.service';
import { AdsModule } from './ads/ads.module';

@Module({
  imports: [
    UsersModule,
    PrismaModule,
    PostsModule,
    AuthModule,
    AdsModule,
    ConfigModule.forRoot({ isGlobal: true }),
  ],
  controllers: [],
  providers: [UsersService],
})
export class AppModule {}
