import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Patch,
  Post,
  UseGuards,
  UsePipes,
  ValidationPipe,
} from '@nestjs/common';
import { CreatePostDto } from './dtos/CreatePost.dto';
import { UpdatePostDto } from './dtos/UpdatePost.dto';
import { PostsService } from './posts.service';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';

@Controller('posts')
export class PostsController {
  constructor(private postsService: PostsService) {}

  @Post('create')
  @UsePipes(ValidationPipe)
  createPost(@Body() createPostDto: CreatePostDto) {
    return this.postsService.createPost(createPostDto);
  }

  @Get('list')
  getPosts() {
    return this.postsService.getPosts();
  }

  @Get(':id')
  getPostById(@Param('id') id: string) {
    return this.postsService.getPostById(Number(id));
  }
  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  updatePostById(
    @Param('id', ParseIntPipe) id: string,
    @Body() updatePostDto: UpdatePostDto,
  ) {
    return this.postsService.updatePost(Number(id), updatePostDto);
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  deletePostById(@Param('id', ParseIntPipe) id: string) {
    return this.postsService.deletePost(Number(id));
  }
}
