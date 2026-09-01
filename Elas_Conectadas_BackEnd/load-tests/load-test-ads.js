import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE_URL = 'http://127.0.0.1:8080';

// Cole o JWT real no lugar de TOKEN_AQUI (ou rode com -e ADS_TOKEN=<jwt>).
const TOKEN = __ENV.ADS_TOKEN || 'TOKEN_AQUI';

export const options = {
  vus: 50,
  duration: '30s',
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.01'],
  },
};

export default function () {
  const url = `${BASE_URL}/ads/create`;
  const payload = JSON.stringify({
    title: 'Desconto de 20% no Dia das Mães',
    content:
      'Aproveite nossa promoção especial para todos os serviços agendados nesta semana!',
    type: 'PRODUCT',
    cover: 'https://res.cloudinary.com/demo/image/upload/v1/ads/capa-promo.jpg',
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
