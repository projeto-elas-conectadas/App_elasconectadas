import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
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
  getPostById(@Param('id') id: string) { // Removido o Pipe!
    return this.postsService.getPostById(id); // Removido o Number()
  }

  @UseGuards(JwtAuthGuard)
  @Patch(':id')
  updatePostById(
    @Param('id') id: string, // Removido o Pipe!
    @Body() updatePostDto: UpdatePostDto,
  ) {
    return this.postsService.updatePost(id, updatePostDto); // Removido o Number()
  }

  @UseGuards(JwtAuthGuard)
  @Delete(':id')
  deletePostById(@Param('id') id: string) { // Removido o Pipe!
    return this.postsService.deletePost(id); // Removido o Number()
  }
}