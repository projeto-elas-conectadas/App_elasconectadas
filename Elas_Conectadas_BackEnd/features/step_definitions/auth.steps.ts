import { Given, When, Then, BeforeAll, AfterAll, setDefaultTimeout } from '@cucumber/cucumber';
import { PrismaClient } from '@prisma/client';
import axios from 'axios';
import * as assert from 'assert';
import * as bcrypt from 'bcrypt';

setDefaultTimeout(20_000);

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

  const hashedOTP = await bcrypt.hash(tokenOtp, 12);
  const now = new Date();

  await prisma.oTP.deleteMany({ where: { userId: user.id } });
  await prisma.oTP.create({
    data: {
      userId: user.id,
      token: hashedOTP,
      type: 'OTP',
      expiresAt: new Date(now.getTime() + 12 * 60 * 60 * 1000),
      createAt: now,
    },
  });
});

When('eu envio POST para {string} com o corpo:', { timeout: 20_000 }, async (endpoint: string, docString: string) => {
  const body = JSON.parse(docString);
  
  try {
    response = await axios.post(`${API_URL}${endpoint}`, body, {
      validateStatus: () => true,
      timeout: 20_000,
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