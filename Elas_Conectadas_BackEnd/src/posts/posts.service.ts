import { HttpException, Injectable } from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from 'src/prisma/prisma.service';

@Injectable()
export class PostsService {
  constructor(private prisma: PrismaService) {}

  //cria um post
  createPost(data: Prisma.PostCreateInput) {
    return this.prisma.post.create({
      data: { ...data },
    });
  }

  //retorna todos os posts
  getPosts() {
    return this.prisma.post.findMany();
  }

  //retorna um post por id
  getPostById(id: String) {
    return this.prisma.post.findUnique({
      where: { id },
    });
  }

  //atualiza parcialmente um post por id
  async updatePost(id: String, data: Prisma.PostUpdateInput) {
    const findPost = await this.getPostById(id);
    if (!findPost) throw new HttpException('Post Not Found', 404);
    return this.prisma.post.update({
      where: { id },
      data: { ...data },
    });
  }

  //deleta um post por id
  async deletePost(id: String) {
    const findPost = await this.getPostById(id);
    if (!findPost) throw new HttpException('Post not found', 404);
    return this.prisma.post.delete({ where: { id } });
  }
}
