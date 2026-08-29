# Compatibilidade necessária no backend

Este frontend foi preparado separadamente para que as adaptações do backend
possam ser avaliadas e implementadas antes da integração definitiva.

## Autenticação

- O cliente gerado chama `POST /auth/login`, `POST /auth/request-otp` e
  `POST /auth/verify-otp`.
- O login deve aceitar `email` e `password` e retornar HTTP 201 com:

```json
{
  "access_token": "token-jwt",
  "user": {
    "id": "uuid",
    "email": "usuario@exemplo.com",
    "name": "Nome",
    "role": "USER",
    "accountStatus": "VERIFIED"
  }
}
```

- `phone`, `dob`, `occupation`, endereço, `bio` e `pfp` podem ser nulos ou
  omitidos na resposta. O frontend possui tratamento para esses casos.

## Cadastro e foto de perfil

- `POST /users/register` deve aceitar `pfp` opcional em `CreateUserDto`.
- `pfp` contém uma URL HTTP/HTTPS retornada previamente por
  `POST /upload/imagem`.
- Como o backend usa `whitelist` e `forbidNonWhitelisted`, o campo precisa estar
  declarado e validado no DTO do NestJS, além do contrato OpenAPI.

## Upload

- `POST /upload/imagem` recebe o campo multipart `file`.
- A resposta HTTP 201 precisa ter o formato `{ "imageUrl": "https://..." }`.
- O frontend chama esse endpoint uma vez para cada foto escolhida.

## Produtos e serviços

- `POST /produtos` deve aceitar `imagemPrincipal` e
  `imagensAdicionais: string[]` opcional.
- `GET /produtos`, `POST /produtos` e `GET /produtos/{id}` precisam declarar no
  OpenAPI respostas compatíveis com `ProdutoResponseDto`.
- O banco e o backend do ramo `origin/main` já possuem suporte de execução para
  várias imagens; falta preservar a tipagem das respostas no contrato.

## Contrato OpenAPI

As respostas de login, cadastro, upload e produtos devem permanecer declaradas
no OpenAPI. Se o cliente Dart for regenerado a partir de respostas sem schema,
as operações serão geradas como `Response<void>` e os serviços deste frontend
deixarão de compilar.

Não é necessária uma nova migração do Prisma: `User.pfp` e
`Produto.imagensAdicionais` já existem no schema atual.
