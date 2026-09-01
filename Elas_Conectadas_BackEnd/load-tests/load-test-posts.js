import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE_URL = 'http://127.0.0.1:8080';

// Cole o JWT real no lugar de TOKEN_AQUI (ou rode com -e POSTS_TOKEN=<jwt>).
const TOKEN = __ENV.POSTS_TOKEN || 'TOKEN_AQUI';

export const options = {
  vus: 50,
  duration: '30s',
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.01'],
  },
};

export default function () {
  const url = `${BASE_URL}/posts/create`;
  const payload = JSON.stringify({
    title: 'Workshop: Finanças para Empreendedoras',
    content:
      'Aprenda a gerir o fluxo de caixa do seu negócio em 3 passos...',
    type: 'COURSE',
    cover:
      'https://res.cloudinary.com/demo/image/upload/v1/posts/capa-curso.jpg',
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${TOKEN}`,
    },
  };

  const res = http.post(url, payload, params);

  check(res, {
    'status é 201': (r) => r.status === 201,
    'resposta é objeto': (r) => {
      try {
        const body = r.json();
        return body !== null && typeof body === 'object' && !Array.isArray(body);
      } catch {
        return false;
      }
    },
  });

  sleep(1);
}
