import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 50,
  duration: '30s',
  thresholds: {
    http_req_duration: ['p(95)<500'],
    http_req_failed: ['rate<0.01'],
  },
};

export default function () {
  const url = 'http://127.0.0.1:8080/auth/login';
  const payload = JSON.stringify({
    email: 'admin@elasconectadas.com',
    password: 'Senha123!'
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  const res = http.post(url, payload, params);
  
  check(res, {
    'status é 201': (r) => r.status === 201,
  });
  
  sleep(1);
}