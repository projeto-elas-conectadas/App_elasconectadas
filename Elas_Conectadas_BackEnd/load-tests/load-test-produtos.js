import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE_URL = 'http://127.0.0.1:8080';

export const options = {
  vus: 50,
  duration: '30s',
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.01'],
  },
};

export function setup() {
  const loginRes = http.post(
    `${BASE_URL}/auth/login`,
    JSON.stringify({
      email: 'leandrodefreitas48@gmail.com',
      password: '35432279',
    }),
    {
      headers: {
        'Content-Type': 'application/json',
      },
    },
  );

  const body = loginRes.json();

  if (loginRes.status !== 201 || !body.access_token || !body.user || !body.user.id) {
    throw new Error(
      `Falha no login de setup. Status ${loginRes.status}. Corpo: ${loginRes.body}`,
    );
  }

  return {
    token: body.access_token,
    userId: body.user.id,
  };
}

export default function (data) {
  const url = `${BASE_URL}/produtos`;
  const payload = JSON.stringify({
    nome: 'Consultoria de TI',
    descricao: 'Consultoria para pequenas empresas',
    preco: 'R$ 120,00 - R$ 200,00',
    categoria: 'Serviço',
    imagemPrincipal: 'https://minhaimagem.com/principal.jpg',
    imagensAdicionais: [
      'https://minhaimagem.com/foto2.jpg',
      'https://minhaimagem.com/foto3.jpg',
    ],
    userId: data.userId,
    regiaoAtendimento: 'Bandeirantes, Itambaracá ou a domicílio',
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${data.token}`,
    },
  };

  const res = http.post(url, payload, params);

  check(res, {
    'status é 201': (r) => r.status === 201,
  });

  sleep(1);
}
