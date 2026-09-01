import { Given, When, Then, BeforeAll, AfterAll, setDefaultTimeout } from '@cucumber/cucumber';
import { PrismaClient } from '@prisma/client';
import axios, { AxiosResponse } from 'axios';
import * as assert from 'assert';
import * as bcrypt from 'bcrypt';

setDefaultTimeout(20_000);

const prisma = new PrismaClient();
const API_URL = 'http://127.0.0.1:8080';

const TEST_EMAIL = 'ads.bdd@elasconectadas.com';
const TEST_PASSWORD = 'Senha123!';
const TEST_TITLE_PREFIX = '[BDD-ADS]';

let response: AxiosResponse;
let accessToken = '';
let adId = '';

async function limparDadosDeTesteAds(): Promise<void> {
  const anuncios = await prisma.ads.findMany({
    where: { title: { startsWith: TEST_TITLE_PREFIX } },
    select: { id: true },
  });
  const ids = anuncios.map((ad) => ad.id);

  if (ids.length > 0) {
    await prisma.advertisingOnUsers.deleteMany({
      where: { advertisingId: { in: ids } },
    });
    await prisma.ads.deleteMany({
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
  return endpoint.replaceAll('<adId>', adId);
}

function assertObjetoDoContrato(body: unknown, contexto: string): void {
  assert.ok(
    body !== null && typeof body === 'object' && !Array.isArray(body),
    `${contexto}: o schema da aba responses é type: object, mas veio: ${JSON.stringify(body)}`,
  );
}

BeforeAll({ timeout: 20_000 }, async () => {
  await limparDadosDeTesteAds();
});

AfterAll({ timeout: 20_000 }, async () => {
  await limparDadosDeTesteAds();
  await prisma.$disconnect();
});

Given(
  'que existe uma anunciante autenticada para o módulo de ads',
  { timeout: 20_000 },
  async () => {
    let anunciante = await prisma.user.findUnique({
      where: { email: TEST_EMAIL },
    });

    if (!anunciante) {
      const hashedPassword = await bcrypt.hash(TEST_PASSWORD, 10);
      anunciante = await prisma.user.create({
        data: {
          email: TEST_EMAIL,
          password: hashedPassword,
          name: 'Anunciante BDD Ads',
          phone: '43988888888',
          dob: '1990-01-01',
          role: 'USER',
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
      `Falha ao autenticar a anunciante de ads. Status ${loginResponse.status}. Corpo: ${JSON.stringify(loginResponse.data)}`,
    );

    accessToken = loginResponse.data?.access_token;
    assert.ok(
      accessToken,
      'O login não retornou access_token. As rotas de ads exigem bearerAuth no contrato.',
    );
  },
);

Given(
  'que existe um anúncio cadastrado para os testes de ads',
  { timeout: 20_000 },
  async () => {
    const anuncio = await prisma.ads.create({
      data: {
        title: `${TEST_TITLE_PREFIX} Anúncio pré-requisito`,
        content:
          'Aproveite nossa promoção especial para todos os serviços agendados nesta semana!',
        type: 'PRODUCT',
        cover:
          'https://res.cloudinary.com/demo/image/upload/v1/ads/capa-promo.jpg',
      },
    });
    adId = anuncio.id;
  },
);

When(
  'eu envio POST autenticado de ads para {string} com o corpo:',
  { timeout: 20_000 },
  async (endpoint: string, docString: string) => {
    const body = JSON.parse(docString);

    try {
      response = await axios.post(`${API_URL}${resolverRota(endpoint)}`, body, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de ads: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio GET autenticado de ads para {string}',
  { timeout: 20_000 },
  async (endpoint: string) => {
    try {
      response = await axios.get(`${API_URL}${resolverRota(endpoint)}`, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de ads: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio PATCH autenticado de ads para {string} com o corpo:',
  { timeout: 20_000 },
  async (endpoint: string, docString: string) => {
    const body = JSON.parse(docString);

    try {
      response = await axios.patch(`${API_URL}${resolverRota(endpoint)}`, body, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de ads: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio DELETE autenticado de ads para {string}',
  { timeout: 20_000 },
  async (endpoint: string) => {
    try {
      response = await axios.delete(`${API_URL}${resolverRota(endpoint)}`, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de ads: ${error}`);
      throw error;
    }
  },
);

Then(
  'a resposta da API de ads deve ter status {int}',
  (expectedStatus: number) => {
    assert.strictEqual(
      response.status,
      expectedStatus,
      `O status esperado era ${expectedStatus}, mas retornou ${response.status}. Corpo: ${JSON.stringify(response.data)}`,
    );
  },
);

Then('o JSON retornado deve ser um objeto conforme o contrato de ads', () => {
  assertObjetoDoContrato(response.data, 'Resposta de item único');
});

Then(
  'o JSON retornado deve ser uma lista de objetos conforme o contrato de ads',
  () => {
    assert.ok(
      Array.isArray(response.data),
      `GET /ads/list deve retornar array (schema type: array). Veio: ${JSON.stringify(response.data)}`,
    );

    response.data.forEach((item: unknown, index: number) => {
      assertObjetoDoContrato(item, `GET /ads/list[${index}]`);
    });
  },
);
