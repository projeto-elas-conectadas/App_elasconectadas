# language: pt
Funcionalidade: Anúncios
  Validação de contrato OpenAPI do módulo Ads, conforme api-specs/modules/ads.yaml.

  Sucesso: POST /ads/create (201), GET /ads/list (200), GET /ads/{id} (200),
  PATCH /ads/{id} (200) e DELETE /ads/{id} (200). O JSON deve corresponder ao
  schema da aba responses — objeto para item único e array de objetos para a lista.

  Falha: 400 quando o corpo viola CreateAdDto (title, content, type obrigatórios)
  ou UpdateAdDto (cover com format uri).

  Todas as rotas exigem bearerAuth.

  Contexto:
    Dado que existe uma anunciante autenticada para o módulo de ads

  # --- CENÁRIOS DE SUCESSO ---

  Cenário: Cria um anúncio com os campos obrigatórios do CreateAdDto
    Quando eu envio POST autenticado de ads para "/ads/create" com o corpo:
      """
      {
        "title": "[BDD-ADS] Desconto de 20% no Dia das Mães",
        "content": "Aproveite nossa promoção especial para todos os serviços agendados nesta semana!",
        "type": "PRODUCT",
        "cover": "https://res.cloudinary.com/demo/image/upload/v1/ads/capa-promo.jpg"
      }
      """
    Então a resposta da API de ads deve ter status 201
    E o JSON retornado deve ser um objeto conforme o contrato de ads

  Cenário: Lista todos os anúncios
    Dado que existe um anúncio cadastrado para os testes de ads
    Quando eu envio GET autenticado de ads para "/ads/list"
    Então a resposta da API de ads deve ter status 200
    E o JSON retornado deve ser uma lista de objetos conforme o contrato de ads

  Cenário: Busca um anúncio por ID
    Dado que existe um anúncio cadastrado para os testes de ads
    Quando eu envio GET autenticado de ads para "/ads/<adId>"
    Então a resposta da API de ads deve ter status 200
    E o JSON retornado deve ser um objeto conforme o contrato de ads

  Cenário: Atualiza um anúncio existente
    Dado que existe um anúncio cadastrado para os testes de ads
    Quando eu envio PATCH autenticado de ads para "/ads/<adId>" com o corpo:
      """
      {
        "title": "[BDD-ADS] Título atualizado",
        "content": "Conteúdo atualizado do anúncio",
        "type": "SERVICE"
      }
      """
    Então a resposta da API de ads deve ter status 200
    E o JSON retornado deve ser um objeto conforme o contrato de ads

  Cenário: Remove um anúncio
    Dado que existe um anúncio cadastrado para os testes de ads
    Quando eu envio DELETE autenticado de ads para "/ads/<adId>"
    Então a resposta da API de ads deve ter status 200
    E o JSON retornado deve ser um objeto conforme o contrato de ads

  # --- CENÁRIOS DE FALHA (400) ---

  Cenário: Rejeita criação com corpo vazio
    Quando eu envio POST autenticado de ads para "/ads/create" com o corpo:
      """
      {}
      """
    Então a resposta da API de ads deve ter status 400

  Cenário: Rejeita criação sem os campos obrigatórios
    Quando eu envio POST autenticado de ads para "/ads/create" com o corpo:
      """
      {
        "title": "[BDD-ADS] Sem content e type"
      }
      """
    Então a resposta da API de ads deve ter status 400

  Cenário: Rejeita atualização com cover que não é URI
    Dado que existe um anúncio cadastrado para os testes de ads
    Quando eu envio PATCH autenticado de ads para "/ads/<adId>" com o corpo:
      """
      {
        "cover": "nao-e-uma-uri"
      }
      """
    Então a resposta da API de ads deve ter status 400
