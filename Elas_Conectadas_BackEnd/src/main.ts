import * as dotenv from 'dotenv';
dotenv.config();

import { setDefaultResultOrder } from 'dns';
// Servidores sem IPv6 (ENETUNREACH / EAI_AGAIN) precisam preferir IPv4
// para SMTP do Gmail e api.cloudinary.com.
setDefaultResultOrder('ipv4first');

import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { json, urlencoded } from 'express';
import { AppModule } from './app.module';
import { HttpExceptionFilter } from './common/http-exception.filter';
import { SwaggerModule } from '@nestjs/swagger';
import * as OpenApiValidator from 'express-openapi-validator';
import { join } from 'path';
import * as fs from 'fs';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }),
  );
  app.useGlobalFilters(new HttpExceptionFilter());

  app.enableCors({
    origin: '*',
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    allowedHeaders: 'Content-Type,Authorization',
  });

  // O parser JSON precisa vir ANTES do validador OpenAPI.
  // Sem isso, req.body fica undefined e o cadastro retorna
  // "request must have required property 'body'".
  app.use(json());
  app.use(urlencoded({ extended: true }));

  try {
    // Spec unificada (gerar com: npm run build:spec)
    const apiSpecPath = join(process.cwd(), 'openapi-spec.json');
    const spec = JSON.parse(fs.readFileSync(apiSpecPath, 'utf8'));

    SwaggerModule.setup('api/docs', app, spec);

    app.use(
      OpenApiValidator.middleware({
        apiSpec: apiSpecPath,
        validateRequests: true,
        validateResponses: true,
      }),
    );
    console.log(
      '✅ Documentação e Validação Spec-Driven ativas (openapi-spec.json)!',
    );
  } catch (error) {
    console.error(
      '❌ Erro ao carregar openapi-spec.json. Execute: yarn build:spec',
      error,
    );
  }

  // PORT no .env é a porta SMTP do e-mail. A API usa API_PORT.
  // 0.0.0.0 escuta em todas as interfaces; 127.0.0.1 só aceitaria a própria máquina.
  const host = process.env.API_HOST?.trim() || '0.0.0.0';
  const port = Number(process.env.API_PORT) || 8080;
  await app.listen(port, host);
  console.log(
    `API escutando em ${host}:${port} (aceita chamadas de fora do localhost).`,
  );
  console.log(`Acesso nesta máquina: http://127.0.0.1:${port}`);
  const publicUrl = process.env.PUBLIC_URL?.trim();
  if (publicUrl) {
    console.log(`Servidor publicado: ${publicUrl}`);
  }
}
bootstrap();
