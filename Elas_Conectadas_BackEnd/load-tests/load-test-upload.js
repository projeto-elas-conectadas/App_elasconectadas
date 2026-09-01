import encoding from 'k6/encoding';
import http from 'k6/http';
import { check, sleep } from 'k6';

const BASE_URL = 'http://127.0.0.1:8080';

// PNG 1x1 válido — o contrato exige multipart/form-data com o campo binário "file".
const PNG_1X1 = encoding.b64decode(
  'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==',
);

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
  const url = `${BASE_URL}/upload/imagem`;
  const payload = {
    file: http.file(PNG_1X1, 'teste-upload.png', 'image/png'),
  };

  const params = {
    headers: {
      Authorization: `Bearer ${data.token}`,
    },
  };

  const res = http.post(url, payload, params);

  check(res, {
    'status é 201': (r) => r.status === 201,
    'resposta é UploadResponseDto': (r) => {
      try {
        const body = r.json();
        return (
          body !== null &&
          typeof body === 'object' &&
          !Array.isArray(body) &&
          typeof body.imageUrl === 'string' &&
          /^https?:\/\//.test(body.imageUrl)
        );
      } catch {
        return false;
      }
    },
  });

  sleep(1);
}
