import { Test, TestingModule } from '@nestjs/testing';
import { ProdutosController } from './produtos.controller';
import { ProdutosService } from './produtos.service';

describe('ProdutosController', () => {
  let controller: ProdutosController;

  const produtosServiceMock = {
    create: jest.fn(),
    findAll: jest.fn(),
    findOne: jest.fn(),
    update: jest.fn(),
    remove: jest.fn(),
  };

  beforeEach(async () => {
    jest.clearAllMocks();
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ProdutosController],
      providers: [{ provide: ProdutosService, useValue: produtosServiceMock }],
    }).compile();

    controller = module.get<ProdutosController>(ProdutosController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('encaminha o DTO de criação sem alterar o contrato', async () => {
    const dto = {
      nome: 'Consultoria',
      descricao: 'Consultoria para pequenos negócios',
      preco: 'A partir de R$ 120',
      categoria: 'SERVICE',
      regiaoAtendimento: 'Atendimento on-line',
      userId: '42ddab2c-6d0b-4cf6-8075-8dc038c5096e',
      imagemPrincipal: 'https://res.cloudinary.com/teste/imagem.jpg',
    };
    produtosServiceMock.create.mockResolvedValue({ id: 'produto-id', ...dto });

    await controller.create(dto);

    expect(produtosServiceMock.create).toHaveBeenCalledWith(dto);
  });
});
