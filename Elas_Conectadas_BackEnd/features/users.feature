# language: pt
@users
Funcionalidade: Usuárias
  Validação de contrato OpenAPI do módulo Users, conforme api-specs/modules/users.yaml.

  Sucesso: POST /users/register (201, UserResponseDto), POST /users/admin (201, object),
  GET /users (200, array de UserResponseDto), GET /users/{id} (200, UserResponseDto),
  PATCH /users/{id} (200, object) e DELETE /users/{id} (200, object).

  Falha: 400 quando o corpo viola CreateUserDto (email, password, name, phone, dob
  obrigatórios), CreateAdminDto (email, password, name obrigatórios) ou
  UpdateUserDto (pfp com format uri).

  POST /users/register declara security: []. As demais rotas exigem bearerAuth.

  Contexto:
    Dado que existe uma administradora autenticada para o módulo de users

  # --- CENÁRIOS DE SUCESSO ---

  Cenário: Registra uma nova usuária com os campos obrigatórios do CreateUserDto
    Quando eu envio POST de users para "/users/register" com o corpo:
      """
      {
        "email": "users.bdd.register@elasconectadas.com",
        "password": "SenhaSegura123!",
        "name": "Maria da Silva",
        "phone": "(43) 99999-8888",
        "dob": "15/05/1995",
        "pfp": "https://res.cloudinary.com/demo/image/upload/v1/users/maria.jpg"
      }
      """
    Então a resposta da API de users deve ter status 201
    E o JSON retornado deve corresponder exatamente ao contrato UserResponseDto

  Cenário: Cria uma administradora com os campos obrigatórios do CreateAdminDto
    Quando eu envio POST autenticado de users para "/users/admin" com o corpo:
      """
      {
        "email": "users.bdd.newadmin@elasconectadas.com",
        "password": "SenhaSegura123!",
        "name": "Ana Admin"
      }
      """
    Então a resposta da API de users deve ter status 201
    E o JSON retornado deve ser um objeto conforme o contrato de users

  Cenário: Lista todas as usuárias
    Dado que existe uma usuária cadastrada para os testes de users
    Quando eu envio GET autenticado de users para "/users"
    Então a resposta da API de users deve ter status 200
    E o JSON retornado deve ser uma lista conforme o contrato UserResponseDto

  Cenário: Busca uma usuária por ID
    Dado que existe uma usuária cadastrada para os testes de users
    Quando eu envio GET autenticado de users para "/users/<userId>"
    Então a resposta da API de users deve ter status 200
    E o JSON retornado deve corresponder exatamente ao contrato UserResponseDto

  Cenário: Atualiza os dados de uma usuária
    Dado que existe uma usuária cadastrada para os testes de users
    Quando eu envio PATCH autenticado de users para "/users/<userId>" com o corpo:
      """
      {
        "name": "Maria Silva Santos",
        "phone": "(43) 99999-0000",
        "occupation": "Artesã",
        "bio": "Trabalho com bordados personalizados há 10 anos.",
        "pfp": "https://res.cloudinary.com/demo/image/upload/v1/users/maria-atualizada.jpg",
        "rua": "Rua Principal",
        "numero": "500",
        "bairro": "Centro",
        "cidade": "Itambaracá",
        "estado": "PR"
      }
      """
    Então a resposta da API de users deve ter status 200
    E o JSON retornado deve ser um objeto conforme o contrato de users

  Cenário: Remove uma usuária
    Dado que existe uma usuária cadastrada para os testes de users
    Quando eu envio DELETE autenticado de users para "/users/<userId>"
    Então a resposta da API de users deve ter status 200
    E o JSON retornado deve ser um objeto conforme o contrato de users

  # --- CENÁRIOS DE FALHA (400) ---

  Cenário: Rejeita registro com corpo vazio
    Quando eu envio POST de users para "/users/register" com o corpo:
      """
      {}
      """
    Então a resposta da API de users deve ter status 400

  Cenário: Rejeita registro sem os campos obrigatórios
    Quando eu envio POST de users para "/users/register" com o corpo:
      """
      {
        "email": "users.bdd.incompleto@elasconectadas.com"
      }
      """
    Então a resposta da API de users deve ter status 400

  Cenário: Rejeita registro com e-mail inválido
    Quando eu envio POST de users para "/users/register" com o corpo:
      """
      {
        "email": "nao-e-email",
        "password": "SenhaSegura123!",
        "name": "Maria da Silva",
        "phone": "(43) 99999-8888",
        "dob": "15/05/1995"
      }
      """
    Então a resposta da API de users deve ter status 400

  Cenário: Rejeita criação de admin com corpo vazio
    Quando eu envio POST autenticado de users para "/users/admin" com o corpo:
      """
      {}
      """
    Então a resposta da API de users deve ter status 400

  Cenário: Rejeita criação de admin sem os campos obrigatórios
    Quando eu envio POST autenticado de users para "/users/admin" com o corpo:
      """
      {
        "email": "users.bdd.admin.incompleto@elasconectadas.com"
      }
      """
    Então a resposta da API de users deve ter status 400

  Cenário: Rejeita atualização com pfp que não é URI
    Dado que existe uma usuária cadastrada para os testes de users
    Quando eu envio PATCH autenticado de users para "/users/<userId>" com o corpo:
      """
      {
        "pfp": "nao-e-uma-uri"
      }
      """
    Então a resposta da API de users deve ter status 400
