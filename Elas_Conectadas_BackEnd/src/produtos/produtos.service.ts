import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateProdutoDto } from './dto/create-produto.dto';
import { UpdateProdutoDto } from './dto/update-produto.dto';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class ProdutosService {
  constructor(private prisma: PrismaService) {}

  // POST: Cria um produto
  async create(createProdutoDto: CreateProdutoDto) {
    return await this.prisma.produto.create({
      data: {
        nome: createProdutoDto.nome,
        descricao: createProdutoDto.descricao,
        preco: createProdutoDto.preco,             // Agora o Prisma vai aceitar como string
        categoria: createProdutoDto.categoria,
        regiaoAtendimento: createProdutoDto.regiaoAtendimento, // Campo novo adicionado!
        imagemPrincipal: createProdutoDto.imagemPrincipal,     // Substituiu o antigo imagemUrl
        
        // Se a usuária não mandar fotos extras, salvamos uma lista vazia []
        // O Prisma vai converter isso automaticamente para JSON no MySQL
        imagensAdicionais: createProdutoDto.imagensAdicionais ?? [], 
        
        userId: createProdutoDto.userId,
      },
    });
  }

  // GET: Lista todos os produtos
  async findAll() {
    return await this.prisma.produto.findMany();
  }

  // GET: Busca um produto específico pelo ID
  async findOne(id: string) {
    const produto = await this.prisma.produto.findUnique({
      where: { id },
    });
    
    if (!produto) {
      throw new NotFoundException(`Produto com ID ${id} não encontrado`);
    }
    return produto;
  }

  // PATCH: Atualiza os dados de um produto
  async update(id: string, updateProdutoDto: UpdateProdutoDto) {
    await this.findOne(id); 
    
    // Mapeamos manualmente para evitar conflitos de tipagem entre o DTO e o Prisma
    return await this.prisma.produto.update({
      where: { id },
      data: {
        nome: updateProdutoDto.nome,
        descricao: updateProdutoDto.descricao,
        preco: updateProdutoDto.preco,
        categoria: updateProdutoDto.categoria,
        regiaoAtendimento: updateProdutoDto.regiaoAtendimento,
        imagemPrincipal: updateProdutoDto.imagemPrincipal,
        imagensAdicionais: updateProdutoDto.imagensAdicionais,
      },
    });
  }

  // DELETE: Remove um produto
  async remove(id: string) {
    await this.findOne(id);

    return await this.prisma.produto.delete({
      where: { id },
    });
  }
}