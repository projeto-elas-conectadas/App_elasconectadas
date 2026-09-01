import { Given, When, Then, BeforeAll, AfterAll, setDefaultTimeout } from '@cucumber/cucumber';
import { PrismaClient } from '@prisma/client';
import axios, { AxiosResponse } from 'axios';
import * as assert from 'assert';
import * as bcrypt from 'bcrypt';

setDefaultTimeout(30_000);

const prisma = new PrismaClient();
const API_URL = 'http://127.0.0.1:8080';

const TEST_EMAIL = 'upload.bdd@elasconectadas.com';
const TEST_PASSWORD = 'Senha123!';

const PNG_1X1 = Buffer.from(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
  'base64',
);

const UPLOAD_RESPONSE_REQUIRED = ['imageUrl'] as const;
const UPLOAD_RESPONSE_ALLOWED = new Set<string>([...UPLOAD_RESPONSE_REQUIRED]);

let response: AxiosResponse;
let accessToken = '';

async function limparDadosDeTesteUpload(): Promise<void> {
  await prisma.oTP.deleteMany({
    where: { user: { email: TEST_EMAIL } },
  });
  await prisma.user.deleteMany({
    where: { email: TEST_EMAIL },
  });
}

function authHeaders(): { Authorization: string } {
  return {
    Authorization: `Bearer ${accessToken}`,
  };
}

function criarFormularioComArquivo(nomeArquivo: string): FormData {
  const form = new FormData();
  const arquivo = new File([new Uint8Array(PNG_1X1)], nomeArquivo, {
    type: 'image/png',
  });
  form.append('file', arquivo);
  return form;
}

function isUri(value: string): boolean {
  try {
    const url = new URL(value);
    return url.protocol === 'http:' || url.protocol === 'https:';
  } catch {
    return false;
  }
}

function assertUploadResponseDto(body: unknown): void {
  assert.ok(
    body !== null && typeof body === 'object' && !Array.isArray(body),
    `UploadResponseDto é type: object. Veio: ${JSON.stringify(body)}`,
  );

  const payload = body as Record<string, unknown>;
  const chaves = Object.keys(payload);

  for (const campo of UPLOAD_RESPONSE_REQUIRED) {
    assert.ok(
      campo in payload,
      `UploadResponseDto exige o campo obrigatório "${campo}". JSON: ${JSON.stringify(body)}`,
    );
  }

  for (const chave of chaves) {
    assert.ok(
      UPLOAD_RESPONSE_ALLOWED.has(chave),
      `UploadResponseDto não declara a propriedade "${chave}". JSON: ${JSON.stringify(body)}`,
    );
  }

  assert.strictEqual(
    typeof payload.imageUrl,
    'string',
    `UploadResponseDto.imageUrl deve ser string. Valor: ${JSON.stringify(payload.imageUrl)}`,
  );

  const imageUrl = payload.imageUrl as string;
  assert.ok(imageUrl.length > 0, 'UploadResponseDto.imageUrl não pode ser vazio.');
  assert.ok(
    isUri(imageUrl),
    `UploadResponseDto.imageUrl deve ter format uri. Valor: ${imageUrl}`,
  );
}

BeforeAll({ timeout: 20_000 }, async () => {
  await limparDadosDeTesteUpload();
});

AfterAll({ timeout: 20_000 }, async () => {
  await limparDadosDeTesteUpload();
  await prisma.$disconnect();
});

Given(
  'que existe uma usuária autenticada para o módulo de upload',
  { timeout: 20_000 },
  async () => {
    let usuaria = await prisma.user.findUnique({
      where: { email: TEST_EMAIL },
    });

    if (!usuaria) {
      const hashedPassword = await bcrypt.hash(TEST_PASSWORD, 10);
      usuaria = await prisma.user.create({
        data: {
          email: TEST_EMAIL,
          password: hashedPassword,
          name: 'Usuária BDD Upload',
          phone: '43966666666',
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
      `Falha ao autenticar a usuária de upload. Status ${loginResponse.status}. Corpo: ${JSON.stringify(loginResponse.data)}`,
    );

    accessToken = loginResponse.data?.access_token;
    assert.ok(
      accessToken,
      'O login não retornou access_token. O header Authorization Bearer será injetado nas requisições de upload.',
    );
  },
);

When(
  'eu envio POST multipart de upload para {string} com o arquivo {string}',
  { timeout: 30_000 },
  async (endpoint: string, nomeArquivo: string) => {
    try {
      response = await axios.post(
        `${API_URL}${endpoint}`,
        criarFormularioComArquivo(nomeArquivo),
        {
          headers: authHeaders(),
          validateStatus: () => true,
        },
      );
    } catch (error) {
      console.error(`Erro ao bater na API de upload: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio POST de upload para {string} com o corpo vazio',
  { timeout: 20_000 },
  async (endpoint: string) => {
    try {
      response = await axios.post(`${API_URL}${endpoint}`, undefined, {
        headers: {
          ...authHeaders(),
          'Content-Type': 'application/json',
        },
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de upload: ${error}`);
      throw error;
    }
  },
);

When(
  'eu envio POST multipart de upload para {string} sem o campo file',
  { timeout: 20_000 },
  async (endpoint: string) => {
    const form = new FormData();
    form.append('outroCampo', 'sem-o-arquivo-obrigatorio');

    try {
      response = await axios.post(`${API_URL}${endpoint}`, form, {
        headers: authHeaders(),
        validateStatus: () => true,
      });
    } catch (error) {
      console.error(`Erro ao bater na API de upload: ${error}`);
      throw error;
    }
  },
);

Then(
  'a resposta da API de upload deve ter status {int}',
  (expectedStatus: number) => {
    assert.strictEqual(
      response.status,
      expectedStatus,
      `O status esperado era ${expectedStatus}, mas retornou ${response.status}. Corpo: ${JSON.stringify(response.data)}`,
    );
  },
);

Then(
  'o JSON retornado deve corresponder exatamente ao contrato UploadResponseDto',
  () => {
    assertUploadResponseDto(response.data);
  },
);
