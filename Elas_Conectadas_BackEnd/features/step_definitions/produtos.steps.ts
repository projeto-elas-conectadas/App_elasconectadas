import { Given, When, Then, BeforeAll, AfterAll } from '@cucumber/cucumber';
import { PrismaClient } from '@prisma/client';
import axios, { AxiosResponse } from 'axios';
import * as assert from 'assert';
import * as bcrypt from 'bcrypt';

const prisma = new PrismaClient();
const API_URL = 'http://127.0.0.1:8080';

const TEST_EMAIL = 'produtos.bdd@elasconectadas.com';
const TEST_PASSWORD = 'Senha123!';

let response: AxiosResponse;
let accessToken = '';
let anuncianteId = '';

const PRODUTO_RESPONSE_REQUIRED = [
  'id',
  'nome',
  'descricao',
  'preco',
  'categoria',
  'imagemPrincipal',
  'userId',
  'regiaoAtendimento',
  'criado_em',
] as const;

const PRODUTO_RESPONSE_OPTIONAL = ['imagensAdicionais'] as const;

const PRODUTO_RESPONSE_ALLOWED = new Set<string>([
  ...PRODUTO_RESPONSE_REQUIRED,
  ...PRODUTO_RESPONSE_OPTIONAL,
]);

const UUID_RE =
  /^[0-9a-f]{8}-[0-9a-f]{4}-[1-8][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i;
const DATE_TIME_RE =
  /^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:\.\d+)?(?:Z|[+-]\d{2}:\d{2})$/;

async function limparAnuncianteDeTeste(): Promise<void> {
  await prisma.produto.deleteMany({
    where: { usuario: { email: TEST_EMAIL } },
  });
  await prisma.oTP.deleteMany({
    where: { user: { email: TEST_EMAIL } },
  });
  await prisma.user.deleteMany({
    where: { email: TEST_EMAIL },
  });
}

BeforeAll({ timeout: 20_000 }, async () => {
  await limparAnuncianteDeTeste();
});

AfterAll({ timeout: 20_000 }, async () => {
  await limparAnuncianteDeTeste();
  await prisma.$disconnect();
});

Given(
  'que existe uma anunciante autenticada para o cadastro de produtos',
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
          name: 'Anunciante BDD Produtos',
          phone: '43999999999',
          dob: '1990-01-01',
          role: 'USER',
          accountStatus: 'VERIFIED',
        },
      });
    }

    anuncianteId = anunciante.id;

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
      `Falha ao autenticar a anunciante de teste. Status ${loginResponse.status}. Corpo: ${JSON.stringify(loginResponse.data)}`,
    );

    accessToken = loginResponse.data?.access_token;
    assert.ok(
      accessToken,
      'O login não retornou access_token. O POST /produtos exige bearerAuth no contrato.',
    );
  },
);

When(
  'eu envio POST autenticado para {string} com o corpo:',
  { timeout: 20_000 },
  async (endpoint: string, docString: string) => {
    const body = JSON.parse(docString.replaceAll('<userId>', anuncianteId));

    try {
      response = await axios.post(`${API_URL}${endpoint}`, body, {
        headers: {
          Authorization: `Bearer ${accessToken}`,
          'Content-Type': 'application/json',
        },
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API: ${error}`);
      throw error;
    }
  },
);

Then(
  'a resposta da API de produtos deve ter status {int}',
  (expectedStatus: number) => {
    assert.strictEqual(
      response.status,
      expectedStatus,
      `O status esperado era ${expectedStatus}, mas retornou ${response.status}. Corpo: ${JSON.stringify(response.data)}`,
    );
  },
);

Then(
  'o JSON retornado deve corresponder exatamente ao contrato ProdutoResponseDto',
  () => {
    assertProdutoResponseDto(response.data);
  },
);

function assertProdutoResponseDto(body: unknown): void {
  assert.ok(
    body !== null && typeof body === 'object' && !Array.isArray(body),
    `O corpo da resposta 201 deveria ser um objeto ProdutoResponseDto, mas veio: ${JSON.stringify(body)}`,
  );

  const produto = body as Record<string, unknown>;
  const chaves = Object.keys(produto);

  const extras = chaves.filter((chave) => !PRODUTO_RESPONSE_ALLOWED.has(chave));
  assert.deepStrictEqual(
    extras,
    [],
    `O JSON de sucesso contém propriedades fora do contrato ProdutoResponseDto: ${extras.join(', ')}`,
  );

  for (const campo of PRODUTO_RESPONSE_REQUIRED) {
    assert.ok(
      campo in produto,
      `Faltou o campo obrigatório "${campo}" definido em ProdutoResponseDto.`,
    );
  }

  assertStringFormat(produto.id, 'id', 'uuid');
  assertString(produto.nome, 'nome');
  assertString(produto.descricao, 'descricao');
  assertString(produto.preco, 'preco');
  assertString(produto.categoria, 'categoria');
  assertStringFormat(produto.imagemPrincipal, 'imagemPrincipal', 'uri');
  assertStringFormat(produto.userId, 'userId', 'uuid');
  assertString(produto.regiaoAtendimento, 'regiaoAtendimento');
  assertStringFormat(produto.criado_em, 'criado_em', 'date-time');

  if ('imagensAdicionais' in produto) {
    assertImagensAdicionais(produto.imagensAdicionais);
  }
}

function assertString(value: unknown, campo: string): void {
  assert.strictEqual(
    typeof value,
    'string',
    `ProdutoResponseDto.${campo} deve ser string. Valor recebido: ${JSON.stringify(value)}`,
  );
  assert.ok(
    (value as string).length > 0,
    `ProdutoResponseDto.${campo} não pode ser vazio.`,
  );
}

function assertStringFormat(
  value: unknown,
  campo: string,
  format: 'uuid' | 'uri' | 'date-time',
): void {
  assertString(value, campo);
  const texto = value as string;

  if (format === 'uuid') {
    assert.match(
      texto,
      UUID_RE,
      `ProdutoResponseDto.${campo} deve ter format uuid. Valor recebido: ${texto}`,
    );
    return;
  }

  if (format === 'uri') {
    assert.ok(
      isUri(texto),
      `ProdutoResponseDto.${campo} deve ter format uri. Valor recebido: ${texto}`,
    );
    return;
  }

  assert.match(
    texto,
    DATE_TIME_RE,
    `ProdutoResponseDto.${campo} deve ter format date-time. Valor recebido: ${texto}`,
  );
  assert.ok(
    !Number.isNaN(Date.parse(texto)),
    `ProdutoResponseDto.${campo} não é uma data/hora válida: ${texto}`,
  );
}

function assertImagensAdicionais(value: unknown): void {
  if (value === null) {
    return;
  }

  assert.ok(
    Array.isArray(value),
    `ProdutoResponseDto.imagensAdicionais deve ser array ou null. Valor recebido: ${JSON.stringify(value)}`,
  );

  value.forEach((item, index) => {
    assert.strictEqual(
      typeof item,
      'string',
      `ProdutoResponseDto.imagensAdicionais[${index}] deve ser string uri.`,
    );
    assert.ok(
      isUri(item),
      `ProdutoResponseDto.imagensAdicionais[${index}] deve ter format uri. Valor recebido: ${item}`,
    );
  });
}

function isUri(value: string): boolean {
  try {
    const url = new URL(value);
    return url.protocol === 'http:' || url.protocol === 'https:';
  } catch {
    return false;
  }
}
