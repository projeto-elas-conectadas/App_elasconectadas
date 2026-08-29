import { Given, When, Then, BeforeAll, AfterAll } from '@cucumber/cucumber';
import { PrismaClient } from '@prisma/client';
import axios from 'axios';
import * as assert from 'assert';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();
const API_URL = 'http://127.0.0.1:8080';
let response: any;

// Hook para limpar os dados de teste antes de tudo
BeforeAll(async () => {
  // Limpa os OTPs primeiro para evitar erro de Foreign Key
  await prisma.oTP.deleteMany({
    where: { user: { email: 'admin@elasconectadas.com' } }
  });
  // Depois limpa o Usuário
  await prisma.user.deleteMany({
    where: { email: 'admin@elasconectadas.com' },
  });
});

// Hook para fechar a conexão do Prisma no final
AfterAll(async () => {
  await prisma.oTP.deleteMany({
    where: { user: { email: 'admin@elasconectadas.com' } }
  });
  await prisma.user.deleteMany({
    where: { email: 'admin@elasconectadas.com' },
  });
  await prisma.$disconnect();
});

Given('que existe um usuário no banco com email {string} e senha {string}', async (email: string, passwordPlana: string) => {
  const hashedPassword = await bcrypt.hash(passwordPlana, 10); 
  
  await prisma.user.create({
    data: {
      email: email,
      password: hashedPassword,
      name: 'Usuária de Teste BDD',
      phone: '11999999999',
      dob: '1990-01-01', // Corrigido para String conforme o schema
      role: 'ADMIN',     // Campo obrigatório do seu schema
      accountStatus: 'VERIFIED' // O seu achado de ouro!
    },
  });
});

Given('que o usuário {string} possui o OTP {string}', async (email: string, tokenOtp: string) => {
  // 1. Busca o ID do usuário criado
  const user = await prisma.user.findUnique({
    where: { email: email }
  });

  if (!user) throw new Error('Usuário de teste não encontrado');

  // 2. Insere o OTP na tabela correta referenciando o ID do usuário
  await prisma.oTP.create({
    data: {
      userId: user.id,
      token: tokenOtp,
      type: 'OTP',
      expiresAt: new Date(Date.now() + 15 * 60 * 1000), // Data de expiração para daqui a 15 minutos
    },
  });
});

When('eu envio POST para {string} com o corpo:', async (endpoint: string, docString: string) => {
  const body = JSON.parse(docString);
  
  try {
    response = await axios.post(`${API_URL}${endpoint}`, body, {
      validateStatus: () => true, 
    });
  } catch (error) {
    console.error(`Erro ao bater na API: ${error}`);
    throw error;
  }
});

Then('a resposta deve ter status {int}', function (expectedStatus: number) {
  assert.strictEqual(
    response.status, 
    expectedStatus, 
    `O status esperado era ${expectedStatus}, mas retornou ${response.status}. Corpo: ${JSON.stringify(response.data)}`
  );
});