# language: pt
Funcionalidade: Criação de produtos e serviços
  Validação de contrato OpenAPI do POST /produtos (CreateProdutoDto na entrada
  e ProdutoResponseDto na saída), conforme api-specs/modules/products.yaml.

  O JSON de sucesso (201) deve conter exatamente as propriedades, tipos e
  formatos descritos em components.schemas.ProdutoResponseDto — o contrato de
  resposta deste recurso no YAML.

  Contexto:
    Dado que existe uma anunciante autenticada para o cadastro de produtos

  # --- CENÁRIOS DE SUCESSO (201) ---

  Cenário: Cria um produto com todos os campos obrigatórios
    Quando eu envio POST autenticado para "/produtos" com o corpo:
      """
      {
        "nome": "Sabonete artesanal de lavanda",
        "descricao": "Sabonete natural feito à mão com essência de lavanda",
        "preco": "R$ 15,00",
        "categoria": "Produto",
        "imagemPrincipal": "https://minhaimagem.com/principal.jpg",
        "imagensAdicionais": [
          "https://minhaimagem.com/foto2.jpg",
          "https://minhaimagem.com/foto3.jpg"
        ],
        "userId": "<userId>",
        "regiaoAtendimento": "Bandeirantes, Itambaracá ou a domicílio"
      }
      """
    Então a resposta da API de produtos deve ter status 201
    E o JSON retornado deve corresponder exatamente ao contrato ProdutoResponseDto

  Cenário: Cria um serviço com todos os campos obrigatórios
    Quando eu envio POST autenticado para "/produtos" com o corpo:
      """
      {
        "nome": "Consultoria de TI",
        "descricao": "Consultoria para pequenas empresas",
        "preco": "R$ 120,00 - R$ 200,00",
        "categoria": "Serviço",
        "imagemPrincipal": "https://minhaimagem.com/principal.jpg",
        "userId": "<userId>",
        "regiaoAtendimento": "Bandeirantes, Itambaracá ou a domicílio"
      }
      """
    Então a resposta da API de produtos deve ter status 201
    E o JSON retornado deve corresponder exatamente ao contrato ProdutoResponseDto

  # --- CENÁRIOS DE FALHA (400) ---

  Cenário: Rejeita criação sem nenhum campo obrigatório
    Quando eu envio POST autenticado para "/produtos" com o corpo:
      """
      {}
      """
    Então a resposta da API de produtos deve ter status 400

  Cenário: Rejeita criação com campos obrigatórios ausentes
    Quando eu envio POST autenticado para "/produtos" com o corpo:
      """
      {
        "nome": "Consultoria de TI"
      }
      """
    Então a resposta da API de produtos deve ter status 400
