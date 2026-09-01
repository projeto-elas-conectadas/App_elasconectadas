import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 50,
  duration: '30s',
  thresholds: {
    // Login usa bcrypt (threadpool do Node ~4 threads). Com 50 VUs o p95
    // fica na casa dos segundos; o SLO de 500ms vale para POST /produtos.
    http_req_duration: ['p(95)<4000'],
    http_req_failed: ['rate<0.01'],
  },
};

export default function () {
  const url = 'http://127.0.0.1:8080/auth/login';
  const payload = JSON.stringify({
    email: 'leandrodefreitas48@gmail.com',
    password: '35432279'
  });

  const params = {
    headers: {
      'Content-Type': 'application/json',
    },
  };

  const res = http.post(url, payload, params);
  const body = res.json();

  check(res, {
    'status é 201': (r) => r.status === 201,
    'retorna access_token': () => typeof body.access_token === 'string' && body.access_token.length > 0,
    'retorna user.id': () => typeof body.user?.id === 'string' && body.user.id.length > 0,
  });
  
  sleep(1);
}
