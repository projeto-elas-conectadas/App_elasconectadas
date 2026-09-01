# Atualização

Registro breve das mudanças no código. Entradas mais recentes no topo.

---

## 01/09/2026 — Upload: 415 no contrato para corpo vazio / Content-Type errado

- **`api-specs/modules/upload.yaml`**: POST `/upload/imagem` declara `415` (ErroPadrao) quando o Content-Type não é `multipart/form-data`.
- **`features/upload.feature`**: o cenário de corpo vazio passa a esperar 415, alinhado ao validador OpenAPI.

---

## 01/09/2026 — Bateria BDD/k6 do módulo Users e runner SDD conjunto

- **`api-specs/modules/users.yaml`**: PATCH/DELETE `/users/{id}` passam a declarar `200` com `content: application/json` (`type: object`), no mesmo padrão de posts/ads, para o validador de resposta não rejeitar o corpo.
- **`features/users.feature`** e **`features/step_definitions/users.steps.ts`**: Cucumber do contrato `users.yaml` (201/200 com UserResponseDto e falhas 400 sem campos obrigatórios), Axios em `127.0.0.1:8080`, JWT via login nas rotas com bearerAuth e limpeza Prisma no BeforeAll/AfterAll.
- **`load-tests/load-test-users.js`**: pico de 50 VUs / 30s no POST `/users/register` com CreateUserDto válido, Bearer `TOKEN_AQUI` e thresholds p95 < 500ms / erro < 1%.
- **`features/run-all.js`** e **`load-tests/run-all.js`**: passam a incluir users automaticamente (descoberta de `*.feature` e `load-test-*.js`).
- **`run-sdd.js`** e **`package.json`**: `npm run test:cucumber` (todas as features juntas), `npm run test:k6` (todos os k6 juntos) e `npm run test:sdd` (Cucumber depois k6); `test:k6:users` para o módulo só.

---

## 01/09/2026 — k6 de upload com login e user.id no setup

- **`load-tests/load-test-upload.js`**: o `setup` faz login como o de produtos, valida `access_token` e `user.id`, e injeta o Bearer real no POST `/upload/imagem` (o corpo continua só o `file` do YAML).

---

## 01/09/2026 — Bateria BDD/k6 do módulo Upload e runners conjuntos

- **`features/upload.feature`** e **`features/step_definitions/upload.steps.ts`**: Cucumber do contrato `upload.yaml` (sucesso 201 com `file` multipart e falha 400 sem corpo/`file`), Axios em `127.0.0.1:8080`, JWT via login e limpeza Prisma no BeforeAll/AfterAll. O JSON 201 é conferido contra o `UploadResponseDto` (`imageUrl` uri).
- **`load-tests/load-test-upload.js`**: pico de 50 VUs / 30s no POST `/upload/imagem` com PNG válido no campo `file`, Bearer `TOKEN_AQUI` e thresholds p95 < 500ms / erro < 1%. Content-Type fica `multipart/form-data` (exigido pelo YAML, não JSON).
- **`features/run-all.js`**: lista e executa todas as features Cucumber juntas (auth, produtos, ads, posts e upload).
- **`package.json`**: `npm run test:cucumber` passa a usar o runner; `npm run test:k6` continua rodando todos os k6 juntos (inclui upload via `load-test-*.js`); `test:k6:upload` para o módulo só.
