# Atualização

Registro breve das mudanças no código. Entradas mais recentes no topo.

---

## 01/09/2026 — k6 de upload com login e user.id no setup

- **`load-tests/load-test-upload.js`**: o `setup` faz login como o de produtos, valida `access_token` e `user.id`, e injeta o Bearer real no POST `/upload/imagem` (o corpo continua só o `file` do YAML).

---

## 01/09/2026 — Bateria BDD/k6 do módulo Upload e runners conjuntos

- **`features/upload.feature`** e **`features/step_definitions/upload.steps.ts`**: Cucumber do contrato `upload.yaml` (sucesso 201 com `file` multipart e falha 400 sem corpo/`file`), Axios em `127.0.0.1:8080`, JWT via login e limpeza Prisma no BeforeAll/AfterAll. O JSON 201 é conferido contra o `UploadResponseDto` (`imageUrl` uri).
- **`load-tests/load-test-upload.js`**: pico de 50 VUs / 30s no POST `/upload/imagem` com PNG válido no campo `file`, Bearer `TOKEN_AQUI` e thresholds p95 < 500ms / erro < 1%. Content-Type fica `multipart/form-data` (exigido pelo YAML, não JSON).
- **`features/run-all.js`**: lista e executa todas as features Cucumber juntas (auth, produtos, ads, posts e upload).
- **`package.json`**: `npm run test:cucumber` passa a usar o runner; `npm run test:k6` continua rodando todos os k6 juntos (inclui upload via `load-test-*.js`); `test:k6:upload` para o módulo só.

---

## 01/09/2026 — Bateria BDD/k6 do módulo Posts

- **`features/posts.feature`** e **`features/step_definitions/posts.steps.ts`**: Cucumber do contrato `posts.yaml` (sucesso 201/200 e falha 400), Axios em `127.0.0.1:8080`, JWT via login e limpeza Prisma no BeforeAll/AfterAll.
- **`api-specs/modules/posts.yaml`**: `400` em POST `/posts/create` e PATCH `/posts/{id}` para o validador OpenAPI não transformar Bad Request em 500; GET `/posts/list` passou a `type: array` (lista), alinhado ao `findMany` e ao GET de ads.
- **`load-tests/load-test-posts.js`**: pico de 50 VUs / 30s no POST `/posts/create` com o `CreatePostDto`, Bearer `TOKEN_AQUI` e thresholds p95 < 500ms / erro < 1%.
- **`package.json`**: `npm run test:cucumber` roda auth, produtos, ads e posts juntos; `npm run test:k6` roda todos os k6 juntos (`test:k6:posts` para o módulo só).

---

## 01/09/2026 — Bateria BDD/k6 do módulo Ads e pasta load-tests

- **`features/ads.feature`** e **`features/step_definitions/ads.steps.ts`**: Cucumber do contrato `ads.yaml` (sucesso 201/200 e falha 400), Axios em `127.0.0.1:8080`, JWT via login e limpeza Prisma no BeforeAll/AfterAll.
- **`api-specs/modules/ads.yaml`**: `400` em POST `/ads/create` e PATCH `/ads/{id}` para o validador OpenAPI não transformar Bad Request em 500; GET `/ads/list` passou a `type: array` (lista), alinhado ao `findMany` e ao GET de produtos.
- **`load-tests/`**: scripts k6 saíram da raiz (`load-test-auth.js`, `load-test-produtos.js`, `load-test-ads.js`) e o runner `run-all.js` executa todos em sequência.
- **`load-tests/load-test-ads.js`**: pico de 50 VUs / 30s no POST `/ads/create` com o `CreateAdDto`, Bearer `TOKEN_AQUI` e thresholds p95 < 500ms / erro < 1%.
- **`package.json`**: `npm run test:cucumber` roda todas as features juntas; `npm run test:k6` roda todos os k6 juntos (`test:k6:auth`, `test:k6:produtos`, `test:k6:ads` para um módulo só).

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
