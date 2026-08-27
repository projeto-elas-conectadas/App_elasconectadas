import { Test, TestingModule } from '@nestjs/testing';
import { NotFoundException } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { CreateProdutoDto } from './dto/create-produto.dto';
import { ProdutosService } from './produtos.service';

describe('ProdutosService', () => {
  let service: ProdutosService;

  const prismaMock = {
    produto: {
      create: jest.fn(),
      findMany: jest.fn(),
      findUnique: jest.fn(),
      update: jest.fn(),
      delete: jest.fn(),
    },
  };

  const createDto: CreateProdutoDto = {
    nome: 'Bolo artesanal',
    descricao: 'Bolo sob encomenda',
    preco: 'R$ 80 - R$ 120',
    categoria: 'PRODUCT',
    regiaoAtendimento: 'Itambaracá e região',
    userId: '42ddab2c-6d0b-4cf6-8075-8dc038c5096e',
    imagemPrincipal: 'https://res.cloudinary.com/teste/imagem.jpg',
  };

  const produto = {
    id: 'cfe231d2-74a6-44dd-a3dc-fd50c6f73e31',
    ...createDto,
    imagensAdicionais: [],
    criado_em: new Date('2026-08-19T12:00:00.000Z'),
  };

  beforeEach(async () => {
    jest.clearAllMocks();
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        ProdutosService,
        { provide: PrismaService, useValue: prismaMock },
      ],
    }).compile();

    service = module.get<ProdutosService>(ProdutosService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('cria o produto com lista vazia quando não há imagens adicionais', async () => {
    prismaMock.produto.create.mockResolvedValue(produto);

    await expect(service.create(createDto)).resolves.toEqual(produto);
    expect(prismaMock.produto.create).toHaveBeenCalledWith({
      data: {
        nome: createDto.nome,
        descricao: createDto.descricao,
        preco: createDto.preco,
        categoria: createDto.categoria,
        regiaoAtendimento: createDto.regiaoAtendimento,
        imagemPrincipal: createDto.imagemPrincipal,
        imagensAdicionais: [],
        userId: createDto.userId,
      },
    });
  });

  it('lista os produtos retornados pelo Prisma', async () => {
    prismaMock.produto.findMany.mockResolvedValue([produto]);

    await expect(service.findAll()).resolves.toEqual([produto]);
  });

  it('devolve 404 quando o produto não existe', async () => {
    prismaMock.produto.findUnique.mockResolvedValue(null);

    await expect(service.findOne('inexistente')).rejects.toBeInstanceOf(
      NotFoundException,
    );
  });
});
