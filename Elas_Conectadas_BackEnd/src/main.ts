import * as dotenv from 'dotenv';
dotenv.config();

import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { SwaggerModule } from '@nestjs/swagger';
import * as OpenApiValidator from 'express-openapi-validator';
import SwaggerParser from '@apidevtools/swagger-parser';
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

 try {
    const apiSpecPath = join(process.cwd(), 'api-specs', 'main-api.yaml');
    
    // 1. Apenas LÊ a spec para o Swagger UI, não tenta unir (bundle)
    const fileContents = fs.readFileSync(apiSpecPath, 'utf8');
    const spec = require('yamljs').parse(fileContents);
    
    // 2. Configura o Swagger UI
    SwaggerModule.setup('api/docs', app, spec);
    
    // 3. Validador OpenAPI (Ele resolve os $ref internamente com segurança)
    app.use(
      OpenApiValidator.middleware({
        apiSpec: spec,
        validateRequests: true,
        validateResponses: true, 
      }),
    );
    console.log('✅ Documentação e Validação Spec-Driven ativas!');
  } catch (error) {
    console.error('❌ Erro crítico ao carregar especificação:', error);
  }
  
  await app.listen(8080, '0.0.0.0');
}
bootstrap();