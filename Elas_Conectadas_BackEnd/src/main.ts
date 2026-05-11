import * as dotenv from 'dotenv';
dotenv.config();

import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { SwaggerModule } from '@nestjs/swagger';

// --- NOVOS IMPORTS NECESSÁRIOS PARA O SPEC-DRIVEN ---
import SwaggerParser from '@apidevtools/swagger-parser';
import { join } from 'path';
// ----------------------------------------------------

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  
  app.enableCors({
    origin: '*',
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    allowedHeaders: 'Content-Type,Authorization',
  });

  // --- ARQUITETURA SPEC-DRIVEN ---
  try {
    // 1. Aponta para o seu arquivo principal
    const apiSpecPath = join(process.cwd(), 'api-specs', 'main-api.yaml');
    
    // 2. O Parser resolve todos os $ref e junta os módulos
    const bundledSpec = await SwaggerParser.bundle(apiSpecPath);
    
    // 3. Entrega o contrato blindado para o Swagger UI renderizar
    SwaggerModule.setup('api/docs', app, bundledSpec as any);
    
    console.log('✅ Documentação Spec-Driven carregada com sucesso!');
  } catch (error) {
    console.error('❌ Erro ao carregar a especificação YAML:', error);
  }
  // -------------------------------
  
  await app.listen(8080, '0.0.0.0');
}
bootstrap();