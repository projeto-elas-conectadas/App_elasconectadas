import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE_URL = 'http://127.0.0.1:8080';

// Cole o JWT real no lugar de TOKEN_AQUI (ou rode com -e USERS_TOKEN=<jwt>).
const TOKEN = __ENV.USERS_TOKEN || 'TOKEN_AQUI';

export const options = {
  vus: 50,
  duration: '30s',
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.01'],
  },
};

export default function () {
  const url = `${BASE_URL}/users/register`;
  const payload = JSON.stringify({
    email: `empreendedora.vu${__VU}.iter${__ITER}@teste.com`,
    password: 'SenhaSegura123!',
    name: 'Maria da Silva',
    phone: '(43) 99999-8888',
    dob: '15/05/1995',
    pfp: 'https://res.cloudinary.com/demo/image/upload/v1/users/maria.jpg',
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
    'resposta é UserResponseDto': (r) => {
      try {
        const body = r.json();
        return (
          body !== null &&
          typeof body === 'object' &&
          !Array.isArray(body) &&
          typeof body.id === 'string' &&
          typeof body.email === 'string' &&
          typeof body.name === 'string' &&
          (body.role === 'USER' || body.role === 'ADMIN') &&
          (body.accountStatus === 'VERIFIED' ||
            body.accountStatus === 'UNVERIFIED')
        );
      } catch {
        return false;
      }
    },
  });

  sleep(1);
}
