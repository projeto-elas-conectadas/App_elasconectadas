import { HttpException, Injectable } from '@nestjs/common';
import { PostType } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';
import { CreatePostDto } from './dtos/CreatePost.dto';
import { UpdatePostDto } from './dtos/UpdatePost.dto';

@Injectable()
export class PostsService {
  constructor(private prisma: PrismaService) {}

  createPost(data: CreatePostDto) {
    return this.prisma.post.create({
      data: {
        title: data.title,
        content: data.content,
        type: data.type as PostType,
        cover: data.cover,
      },
    });
  }

  getPosts() {
    return this.prisma.post.findMany();
  }

  getPostById(id: string) {
    return this.prisma.post.findUnique({
      where: { id },
    });
  }

  async updatePost(id: string, data: UpdatePostDto) {
    const findPost = await this.getPostById(id);
    if (!findPost) throw new HttpException('Post Not Found', 404);

    return this.prisma.post.update({
      where: { id },
      data: {
        title: data.title,
        content: data.content,
        type: data.type as PostType | undefined,
        cover: data.cover,
      },
    });
  }

  async deletePost(id: string) {
    const findPost = await this.getPostById(id);
    if (!findPost) throw new HttpException('Post not found', 404);
    return this.prisma.post.delete({ where: { id } });
  }
}
