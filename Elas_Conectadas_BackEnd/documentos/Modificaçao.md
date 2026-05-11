# Modificação de logica

Escalabilidade: UUIDs (String) são melhores que IDs sequenciais (1, 2, 3...) porque dificultam que um hacker descubra quantos usuários você tem e evita conflitos se você precisar juntar dois bancos de dados no futuro.

Performance: Mudamos Bytes para String (URL). No futuro, em vez de salvar a foto pesada no MySQL, vamos subir a foto para um servidor de arquivos (como Firebase Storage ou AWS S3) e salvar apenas o "link" aqui. Seu banco de dados ficará super leve!

# Segurança.

    Tirei a senha e login do docker compose e coloquei no ponto env

    ```yaml
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_DATABASE: ${DB_NAME}
    ```

# Aplicar o Spec-Driven Development (O Contrato).

Primeiro instalei as dependecias

``` bash

npm install @nestjs/swagger swagger-ui-express

```

### apliquei modificção na main.ts para swagger funciona.

```TypeScript

import * as dotenv from 'dotenv';
dotenv.config();

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
// 1. Novo import do Swagger adicionado aqui:
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  // A sua configuração de CORS mantida intacta
  app.enableCors({
    origin: '*', // Permite qualquer origem (ideal para desenvolvimento local)
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    allowedHeaders: 'Content-Type,Authorization',
  });

  // --- 2. NOVA CONFIGURAÇÃO DO SWAGGER (SPEC-DRIVEN) ---
  const config = new DocumentBuilder()
    .setTitle('API Elas Conectadas')
    .setDescription('Documentação baseada em Spec-Driven Development para o TCC')
    .setVersion('1.0')
    .build();
    
  const document = SwaggerModule.createDocument(app, config);
  
  // A documentação ficará disponível na rota /api/docs
  SwaggerModule.setup('api/docs', app, document);
  // -----------------------------------------------------

  // A sua porta 8080 mantida intacta
  await app.listen(8080, '0.0.0.0');
}
bootstrap();

```
com comando  **http://localhost:8080/api/docs** podemos acessar o menu do swagger na propria maquina

### Criar a Tabela de Produtos no Prisma.

adicionei o schema de produto no prisma

```Snippet de código

model Produto {
  id          String   @id @default(uuid())
  nome        String
  descricao   String
  preco       Float
  categoria   String
  criado_em   DateTime @default(now())

  // Futuramente vamos adicionar a relação com a Empreendedora (User) aqui
}

```
com essa adição colocamos a pasta de produtos no swagger

### adicionando logica no create-produto.dto

usei o proprio construtor do nest agora adiciona as informaçoes nas classes

```Typescript

import { ApiProperty } from '@nestjs/swagger';

export class CreateProdutoDto {
  @ApiProperty({ example: 'Consultoria de Marketing', description: 'Nome do serviço ou produto' })
  nome: string;

  @ApiProperty({ example: 'Mentoria de 1 hora para redes sociais', description: 'Detalhes do que é oferecido' })
  descricao: string;

  @ApiProperty({ example: 150.00, description: 'Valor cobrado' })
  preco: number;

  @ApiProperty({ example: 'Consultoria', description: 'Categoria do produto/serviço' })
  categoria: string;
}

```
**injetando codigo no produto.service**

```typescript

import { Injectable } from '@nestjs/common';
import { CreateProdutoDto } from './dto/create-produto.dto';
import { UpdateProdutoDto } from './dto/update-produto.dto';
import { PrismaService } from '../prisma/prisma.service'; 

@Injectable()
export class ProdutosService {
  // Injetamos o Prisma no "construtor" da classe
  constructor(private prisma: PrismaService) {}

  // Função que realmente salva no banco de dados
  async create(createProdutoDto: CreateProdutoDto) {
    return await this.prisma.produto.create({
      data: createProdutoDto, // Aqui passamos o JSON direto para o banco!
    });
  }

  // Já vamos deixar a função de listar todos pronta também!
  async findAll() {
    return await this.prisma.produto.findMany();
  }

  findOne(id: number) {
    return `This action returns a #${id} produto`;
  }

  update(id: number, updateProdutoDto: UpdateProdutoDto) {
    return `This action updates a #${id} produto`;
  }

  remove(id: number) {
    return `This action removes a #${id} produto`;
  }
}

````

### pontos dos swagger

Documentação Viva: Ele não precisa abrir o código do back. Ele olha o Swagger e vê: "Ah, para cadastrar um produto eu preciso mandar esses 4 campos exatos".

Geração de Código: Existem ferramentas que leem esse seu Swagger e geram automaticamente as classes em Dart/Flutter para você. Você não precisa digitar campo por campo no celular; o Swagger faz isso por você.

Independência: O Front-end pode testar se a lógica dele está certa comparando com o que o Swagger responde. Se o app der erro, mas o Swagger funcionar, ele sabe que o erro está no Flutter.

# ADICIONANDO O CLOUDNARY

primeiro adicione a dados da api depois de criar uma conta gratuito no site da empresa

CLOUDINARY_CLOUD_NAME="seu_cloud_name_aqui"
CLOUDINARY_API_KEY="sua_api_key_aqui"
CLOUDINARY_API_SECRET="seu_api_secret_aqui"

depois instalamos as dependecias

```bash

npm install cloudinary streamifier
npm install -D @types/multer @types/streamifier

```

apliquei a classe validator para garantir a tipagem certa em cada propriedade do bancos de dados