import * as dotenv from 'dotenv';
dotenv.config();

import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { json, urlencoded } from 'express';
import { AppModule } from './app.module';
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
      '❌ Erro ao carregar openapi-spec.json. Execute: npm run build:spec',
      error,
    );
  }

  await app.listen(8080, '0.0.0.0');
}
bootstrap();
