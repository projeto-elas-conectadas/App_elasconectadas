import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateProdutoDto } from './dto/create-produto.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ProdutosService {
  constructor(private prisma: PrismaService) {}

  async create(createProdutoDto: CreateProdutoDto) {
    return this.prisma.produto.create({
      data: {
        nome: createProdutoDto.nome,
        descricao: createProdutoDto.descricao,
        preco: createProdutoDto.preco,
        categoria: createProdutoDto.categoria,
        regiaoAtendimento: createProdutoDto.regiaoAtendimento,
        imagemPrincipal: createProdutoDto.imagemPrincipal,
        imagensAdicionais: createProdutoDto.imagensAdicionais ?? [],
        userId: createProdutoDto.userId,
      },
    });
  }

  async findAll() {
    return this.prisma.produto.findMany();
  }

  async findOne(id: string) {
    const produto = await this.prisma.produto.findUnique({
      where: { id },
    });

    if (!produto) {
      throw new NotFoundException(`Produto com ID ${id} não encontrado`);
    }
    return produto;
  }
}
