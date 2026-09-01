import { Given, When, Then, BeforeAll, AfterAll, setDefaultTimeout } from '@cucumber/cucumber';
import { PrismaClient } from '@prisma/client';
import axios, { AxiosResponse } from 'axios';
import * as assert from 'assert';
import * as bcrypt from 'bcrypt';

setDefaultTimeout(20_000);

const prisma = new PrismaClient();
const API_URL = 'http://127.0.0.1:8080';

const TEST_EMAIL = 'posts.bdd@elasconectadas.com';
const TEST_PASSWORD = 'Senha123!';
const TEST_TITLE_PREFIX = '[BDD-POSTS]';

let response: AxiosResponse;
let accessToken = '';
let postId = '';

async function limparDadosDeTestePosts(): Promise<void> {
  const posts = await prisma.post.findMany({
    where: { title: { startsWith: TEST_TITLE_PREFIX } },
    select: { id: true },
  });
  const ids = posts.map((post) => post.id);

  if (ids.length > 0) {
    await prisma.postOnAdmins.deleteMany({
      where: { postId: { in: ids } },
    });
    await prisma.post.deleteMany({
      where: { id: { in: ids } },
    });
  }

  await prisma.oTP.deleteMany({
    where: { user: { email: TEST_EMAIL } },
  });
  await prisma.user.deleteMany({
    where: { email: TEST_EMAIL },
  });
}

function authHeaders(): { Authorization: string; 'Content-Type': string } {
  return {
    Authorization: `Bearer ${accessToken}`,
    'Content-Type': 'application/json',
  };
}

function resolverRota(endpoint: string): string {
  return endpoint.replaceAll('<postId>', postId);
}

function assertObjetoDoContrato(body: unknown, contexto: string): void {
  assert.ok(
    body !== null && typeof body === 'object' && !Array.isArray(body),
    `${contexto}: o schema da aba responses é type: object, mas veio: ${JSON.stringify(body)}`,
  );
}

BeforeAll({ timeout: 20_000 }, async () => {
  await limparDadosDeTestePosts();
});

AfterAll({ timeout: 20_000 }, async () => {
  await limparDadosDeTestePosts();
  await prisma.$disconnect();
});

Given(
  'que existe uma administradora autenticada para o módulo de posts',
  { timeout: 20_000 },
  async () => {
    let admin = await prisma.user.findUnique({
      where: { email: TEST_EMAIL },
    });

    if (!admin) {
      const hashedPassword = await bcrypt.hash(TEST_PASSWORD, 10);
      admin = await prisma.user.create({
        data: {
          email: TEST_EMAIL,
          password: hashedPassword,
          name: 'Admin BDD Posts',
          phone: '43977777777',
          dob: '1990-01-01',
          role: 'ADMIN',
          accountStatus: 'VERIFIED',
        },
      });
    }

    if (accessToken) {
      return;
    }

    const loginResponse = await axios.post(
      `${API_URL}/auth/login`,
      { email: TEST_EMAIL, password: TEST_PASSWORD },
      { validateStatus: () => true },
    );

    assert.strictEqual(
      loginResponse.status,
      201,
      `Falha ao autenticar a administradora de posts. Status ${loginResponse.status}. Corpo: ${JSON.stringify(loginResponse.data)}`,
    );

    accessToken = loginResponse.data?.access_token;
    assert.ok(
      accessToken,
      'O login não retornou access_token. As rotas de posts exigem bearerAuth no contrato.',
    );
  },
);

Given(
  'que existe um post cadastrado para os testes de posts',
  { timeout: 20_000 },
  async () => {
    const post = await prisma.post.create({
      data: {
        title: `${TEST_TITLE_PREFIX} Post pré-requisito`,
        content:
          'Aprenda a gerir o fluxo de caixa do seu negócio em 3 passos...',
        type: 'COURSE',
        cover:
          'https://res.cloudinary.com/demo/image/upload/v1/posts/capa-curso.jpg',
      },
    });
    postId = post.id;
  },
);

When(
  'eu envio POST autenticado de posts para {string} com o corpo:',
  { timeout: 20_000 },
  async (endpoint: string, docString: string) => {
    const body = JSON.parse(docString);

    try {
      response = await axios.post(`${API_URL}${resolverRota(endpoint)}`, body, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de posts: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio GET autenticado de posts para {string}',
  { timeout: 20_000 },
  async (endpoint: string) => {
    try {
      response = await axios.get(`${API_URL}${resolverRota(endpoint)}`, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de posts: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio PATCH autenticado de posts para {string} com o corpo:',
  { timeout: 20_000 },
  async (endpoint: string, docString: string) => {
    const body = JSON.parse(docString);

    try {
      response = await axios.patch(`${API_URL}${resolverRota(endpoint)}`, body, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de posts: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio DELETE autenticado de posts para {string}',
  { timeout: 20_000 },
  async (endpoint: string) => {
    try {
      response = await axios.delete(`${API_URL}${resolverRota(endpoint)}`, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de posts: ${error}`);
      throw error;
    }
  },
);

Then(
  'a resposta da API de posts deve ter status {int}',
  (expectedStatus: number) => {
    assert.strictEqual(
      response.status,
      expectedStatus,
      `O status esperado era ${expectedStatus}, mas retornou ${response.status}. Corpo: ${JSON.stringify(response.data)}`,
    );
  },
);

Then('o JSON retornado deve ser um objeto conforme o contrato de posts', () => {
  assertObjetoDoContrato(response.data, 'Resposta de item único');
});

Then(
  'o JSON retornado deve ser uma lista de objetos conforme o contrato de posts',
  () => {
    assert.ok(
      Array.isArray(response.data),
      `GET /posts/list deve retornar array (schema type: array). Veio: ${JSON.stringify(response.data)}`,
    );

    response.data.forEach((item: unknown, index: number) => {
      assertObjetoDoContrato(item, `GET /posts/list[${index}]`);
    });
  },
);
