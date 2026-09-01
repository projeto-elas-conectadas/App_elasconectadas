import { Given, When, Then, BeforeAll, AfterAll, setDefaultTimeout } from '@cucumber/cucumber';
import { PrismaClient } from '@prisma/client';
import axios, { AxiosResponse } from 'axios';
import * as assert from 'assert';
import * as bcrypt from 'bcrypt';

setDefaultTimeout(30_000);

const prisma = new PrismaClient();
const API_URL = 'http://127.0.0.1:8080';

const TEST_ADMIN_EMAIL = 'users.bdd.admin@elasconectadas.com';
const TEST_TARGET_EMAIL = 'users.bdd.target@elasconectadas.com';
const TEST_PASSWORD = 'Senha123!';
const EMAIL_PREFIX = 'users.bdd.';

const USER_RESPONSE_REQUIRED = [
  'id',
  'email',
  'name',
  'role',
  'accountStatus',
] as const;

const USER_RESPONSE_OPTIONAL = [
  'phone',
  'dob',
  'occupation',
  'rua',
  'numero',
  'bairro',
  'cidade',
  'estado',
  'bio',
  'pfp',
] as const;

const USER_RESPONSE_ALLOWED = new Set<string>([
  ...USER_RESPONSE_REQUIRED,
  ...USER_RESPONSE_OPTIONAL,
]);

const ROLE_ENUM = new Set(['USER', 'ADMIN']);
const ACCOUNT_STATUS_ENUM = new Set(['VERIFIED', 'UNVERIFIED']);

const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-8][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
const EMAIL_RE = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

let response: AxiosResponse;
let accessToken = '';
let userId = '';

async function limparDadosDeTesteUsers(): Promise<void> {
  const filtroEmail = { email: { startsWith: EMAIL_PREFIX } };

  await prisma.produto.deleteMany({
    where: { usuario: filtroEmail },
  });
  await prisma.advertisingOnUsers.deleteMany({
    where: { user: filtroEmail },
  });
  await prisma.postOnAdmins.deleteMany({
    where: { admin: filtroEmail },
  });
  await prisma.oTP.deleteMany({
    where: { user: filtroEmail },
  });
  await prisma.user.deleteMany({
    where: filtroEmail,
  });
}

function authHeaders(): { Authorization: string; 'Content-Type': string } {
  return {
    Authorization: `Bearer ${accessToken}`,
    'Content-Type': 'application/json',
  };
}

function resolverRota(endpoint: string): string {
  return endpoint.replaceAll('<userId>', userId);
}

function isUri(value: string): boolean {
  try {
    const url = new URL(value);
    return url.protocol === 'http:' || url.protocol === 'https:';
  } catch {
    return false;
  }
}

function assertNullableString(value: unknown, campo: string): void {
  if (value === null) {
    return;
  }

  assert.strictEqual(
    typeof value,
    'string',
    `UserResponseDto.${campo} deve ser string ou null. Valor: ${JSON.stringify(value)}`,
  );
}

function assertUserResponseDto(body: unknown, contexto: string): void {
  assert.ok(
    body !== null && typeof body === 'object' && !Array.isArray(body),
    `${contexto}: UserResponseDto é type: object. Veio: ${JSON.stringify(body)}`,
  );

  const user = body as Record<string, unknown>;
  const chaves = Object.keys(user);

  const extras = chaves.filter((chave) => !USER_RESPONSE_ALLOWED.has(chave));
  assert.deepStrictEqual(
    extras,
    [],
    `${contexto}: propriedades fora do contrato UserResponseDto: ${extras.join(', ')}`,
  );

  for (const campo of USER_RESPONSE_REQUIRED) {
    assert.ok(
      campo in user,
      `${contexto}: faltou o campo obrigatório "${campo}" de UserResponseDto.`,
    );
  }

  assert.strictEqual(typeof user.id, 'string', `${contexto}: id deve ser string uuid.`);
  assert.match(
    user.id as string,
    UUID_RE,
    `${contexto}: id deve ter format uuid. Valor: ${user.id}`,
  );

  assert.strictEqual(typeof user.email, 'string', `${contexto}: email deve ser string.`);
  assert.match(
    user.email as string,
    EMAIL_RE,
    `${contexto}: email deve ter format email. Valor: ${user.email}`,
  );

  assert.strictEqual(typeof user.name, 'string', `${contexto}: name deve ser string.`);
  assert.ok((user.name as string).length > 0, `${contexto}: name não pode ser vazio.`);

  assert.ok(
    typeof user.role === 'string' && ROLE_ENUM.has(user.role),
    `${contexto}: role deve ser USER ou ADMIN. Valor: ${JSON.stringify(user.role)}`,
  );

  assert.ok(
    typeof user.accountStatus === 'string' &&
      ACCOUNT_STATUS_ENUM.has(user.accountStatus),
    `${contexto}: accountStatus deve ser VERIFIED ou UNVERIFIED. Valor: ${JSON.stringify(user.accountStatus)}`,
  );

  for (const campo of USER_RESPONSE_OPTIONAL) {
    if (!(campo in user)) {
      continue;
    }

    assertNullableString(user[campo], campo);

    if (campo === 'pfp' && user.pfp !== null && user.pfp !== undefined) {
      assert.ok(
        isUri(user.pfp as string),
        `${contexto}: pfp deve ter format uri. Valor: ${user.pfp}`,
      );
    }
  }
}

BeforeAll({ timeout: 20_000 }, async () => {
  await limparDadosDeTesteUsers();
});

AfterAll({ timeout: 20_000 }, async () => {
  await limparDadosDeTesteUsers();
  await prisma.$disconnect();
});

Given(
  'que existe uma administradora autenticada para o módulo de users',
  { timeout: 20_000 },
  async () => {
    let admin = await prisma.user.findUnique({
      where: { email: TEST_ADMIN_EMAIL },
    });

    if (!admin) {
      const hashedPassword = await bcrypt.hash(TEST_PASSWORD, 10);
      admin = await prisma.user.create({
        data: {
          email: TEST_ADMIN_EMAIL,
          password: hashedPassword,
          name: 'Admin BDD Users',
          phone: '43955555555',
          dob: '15/05/1990',
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
      { email: TEST_ADMIN_EMAIL, password: TEST_PASSWORD },
      { validateStatus: () => true },
    );

    assert.strictEqual(
      loginResponse.status,
      201,
      `Falha ao autenticar a administradora de users. Status ${loginResponse.status}. Corpo: ${JSON.stringify(loginResponse.data)}`,
    );

    accessToken = loginResponse.data?.access_token;
    assert.ok(
      accessToken,
      'O login não retornou access_token. As rotas protegidas de users exigem bearerAuth no contrato.',
    );
  },
);

Given(
  'que existe uma usuária cadastrada para os testes de users',
  { timeout: 20_000 },
  async () => {
    await prisma.oTP.deleteMany({
      where: { user: { email: TEST_TARGET_EMAIL } },
    });
    await prisma.user.deleteMany({
      where: { email: TEST_TARGET_EMAIL },
    });

    const hashedPassword = await bcrypt.hash(TEST_PASSWORD, 10);
    const usuaria = await prisma.user.create({
      data: {
        email: TEST_TARGET_EMAIL,
        password: hashedPassword,
        name: 'Maria da Silva',
        phone: '(43) 99999-8888',
        dob: '15/05/1995',
        role: 'USER',
        accountStatus: 'VERIFIED',
        pfp: 'https://res.cloudinary.com/demo/image/upload/v1/users/maria.jpg',
      },
    });

    userId = usuaria.id;
  },
);

When(
  'eu envio POST de users para {string} com o corpo:',
  { timeout: 30_000 },
  async (endpoint: string, docString: string) => {
    const body = JSON.parse(docString);

    try {
      response = await axios.post(`${API_URL}${resolverRota(endpoint)}`, body, {
        headers: { 'Content-Type': 'application/json' },
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de users: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio POST autenticado de users para {string} com o corpo:',
  { timeout: 30_000 },
  async (endpoint: string, docString: string) => {
    const body = JSON.parse(docString);

    try {
      response = await axios.post(`${API_URL}${resolverRota(endpoint)}`, body, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de users: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio GET autenticado de users para {string}',
  { timeout: 20_000 },
  async (endpoint: string) => {
    try {
      response = await axios.get(`${API_URL}${resolverRota(endpoint)}`, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de users: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio PATCH autenticado de users para {string} com o corpo:',
  { timeout: 20_000 },
  async (endpoint: string, docString: string) => {
    const body = JSON.parse(docString);

    try {
      response = await axios.patch(`${API_URL}${resolverRota(endpoint)}`, body, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de users: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio DELETE autenticado de users para {string}',
  { timeout: 20_000 },
  async (endpoint: string) => {
    try {
      response = await axios.delete(`${API_URL}${resolverRota(endpoint)}`, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de users: ${error}`);
      throw error;
    }
  },
);

Then(
  'a resposta da API de users deve ter status {int}',
  (expectedStatus: number) => {
    assert.strictEqual(
      response.status,
      expectedStatus,
      `O status esperado era ${expectedStatus}, mas retornou ${response.status}. Corpo: ${JSON.stringify(response.data)}`,
    );
  },
);

Then(
  'o JSON retornado deve corresponder exatamente ao contrato UserResponseDto',
  () => {
    assertUserResponseDto(response.data, 'Resposta de item único');
  },
);

Then('o JSON retornado deve ser um objeto conforme o contrato de users', () => {
  assert.ok(
    response.data !== null &&
      typeof response.data === 'object' &&
      !Array.isArray(response.data),
    `POST /users/admin declara responses 201 como type: object. Veio: ${JSON.stringify(response.data)}`,
  );
});

Then(
  'o JSON retornado deve ser uma lista conforme o contrato UserResponseDto',
  () => {
    assert.ok(
      Array.isArray(response.data),
      `GET /users deve retornar array (schema type: array). Veio: ${JSON.stringify(response.data)}`,
    );

    response.data.forEach((item: unknown, index: number) => {
      assertUserResponseDto(item, `GET /users[${index}]`);
    });
  },
);
