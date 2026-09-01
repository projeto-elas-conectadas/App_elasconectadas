# language: pt
Funcionalidade: Posts
  Validação de contrato OpenAPI do módulo Posts, conforme api-specs/modules/posts.yaml.

  Sucesso: POST /posts/create (201), GET /posts/list (200), GET /posts/{id} (200),
  PATCH /posts/{id} (200) e DELETE /posts/{id} (200). O JSON deve corresponder ao
  schema da aba responses — objeto para item único e array de objetos para a lista.

  Falha: 400 quando o corpo viola CreatePostDto (title, content, type obrigatórios)
  ou UpdatePostDto (cover com format uri).

  Todas as rotas exigem bearerAuth.

  Contexto:
    Dado que existe uma administradora autenticada para o módulo de posts

  # --- CENÁRIOS DE SUCESSO ---

  Cenário: Cria um post com os campos obrigatórios do CreatePostDto
    Quando eu envio POST autenticado de posts para "/posts/create" com o corpo:
      """
      {
        "title": "[BDD-POSTS] Workshop: Finanças para Empreendedoras",
        "content": "Aprenda a gerir o fluxo de caixa do seu negócio em 3 passos...",
        "type": "COURSE",
        "cover": "https://res.cloudinary.com/demo/image/upload/v1/posts/capa-curso.jpg"
      }
      """
    Então a resposta da API de posts deve ter status 201
    E o JSON retornado deve ser um objeto conforme o contrato de posts

  Cenário: Lista todos os posts
    Dado que existe um post cadastrado para os testes de posts
    Quando eu envio GET autenticado de posts para "/posts/list"
    Então a resposta da API de posts deve ter status 200
    E o JSON retornado deve ser uma lista de objetos conforme o contrato de posts

  Cenário: Busca um post por ID
    Dado que existe um post cadastrado para os testes de posts
    Quando eu envio GET autenticado de posts para "/posts/<postId>"
    Então a resposta da API de posts deve ter status 200
    E o JSON retornado deve ser um objeto conforme o contrato de posts

  Cenário: Atualiza um post existente
    Dado que existe um post cadastrado para os testes de posts
    Quando eu envio PATCH autenticado de posts para "/posts/<postId>" com o corpo:
      """
      {
        "title": "[BDD-POSTS] Título atualizado",
        "content": "Conteúdo atualizado do post",
        "type": "EVENT"
      }
      """
    Então a resposta da API de posts deve ter status 200
    E o JSON retornado deve ser um objeto conforme o contrato de posts

  Cenário: Remove um post
    Dado que existe um post cadastrado para os testes de posts
    Quando eu envio DELETE autenticado de posts para "/posts/<postId>"
    Então a resposta da API de posts deve ter status 200
    E o JSON retornado deve ser um objeto conforme o contrato de posts

  # --- CENÁRIOS DE FALHA (400) ---

  Cenário: Rejeita criação com corpo vazio
    Quando eu envio POST autenticado de posts para "/posts/create" com o corpo:
      """
      {}
      """
    Então a resposta da API de posts deve ter status 400

  Cenário: Rejeita criação sem os campos obrigatórios
    Quando eu envio POST autenticado de posts para "/posts/create" com o corpo:
      """
      {
        "title": "[BDD-POSTS] Sem content e type"
      }
      """
    Então a resposta da API de posts deve ter status 400

  Cenário: Rejeita atualização com cover que não é URI
    Dado que existe um post cadastrado para os testes de posts
    Quando eu envio PATCH autenticado de posts para "/posts/<postId>" com o corpo:
      """
      {
        "cover": "nao-e-uma-uri"
      }
      """
    Então a resposta da API de posts deve ter status 400
