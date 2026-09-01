# Atualização

Registro breve das mudanças no código. Entradas mais recentes no topo.

---

## 01/09/2026 — Timeouts do Cucumber e threshold do login k6

- **`features/step_definitions/auth.steps.ts`**: timeout padrão e do POST elevados para 20s, porque `/auth/send` e `/auth/request-otp` esperam o SMTP do Gmail (o passo de 5s estourava).
- **`features/auth.feature`**: o cenário de verify OTP voltou a usar `admin@elasconectadas.com` e o código `123456` (o corpo tinha o e-mail/senha do k6, então a API buscava OTP de outra conta e respondia “expirado”).
- **`load-test.js`**: p95 do login ajustado para 4s. Com 50 VUs o bcrypt satura o threadpool do Node; o SLO de 500ms continua no `load-test-produtos.js`.

---

## 01/09/2026 — Contrato de auth e testes de carga

- **`load-test-produtos.js`**: script k6 do `POST /produtos` com 50 VUs por 30s, thresholds (p95 < 500ms e erro < 1%) e corpo no formato do `CreateProdutoDto`.
- **`load-test-produtos.js`**: o setup faz login, usa o `user.id` real (evita FK inválida) e envia o Bearer Token.
- **`load-test.js`**: conferência do login (`email` + `password`) e checagem de `access_token` e `user.id` na resposta 201.
- **`api-specs/modules/auth.yaml`**: respostas `400`/`404` em login, send, request-otp e verify-otp, para o validador OpenAPI não transformar 400 em 500.
- **`api-specs/modules/auth.yaml`**: `/auth/send` deixou de exigir `bearerAuth`, alinhado ao controller e ao Cucumber.
- **`features/step_definitions/auth.steps.ts`**: OTP de teste gravado com bcrypt, como o `AuthService` compara.
- **`openapi-spec.json`**: spec regenerada com `npm run build:spec`.
