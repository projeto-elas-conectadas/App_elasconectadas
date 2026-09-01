# language: pt
Funcionalidade: Upload de imagem
  Validação de contrato OpenAPI do módulo Uploads, conforme api-specs/modules/upload.yaml.

  Sucesso: POST /upload/imagem (201) com multipart/form-data e o campo obrigatório
  file (format binary). O JSON deve corresponder exatamente ao UploadResponseDto
  da aba responses — objeto com imageUrl (string, format uri).

  Falha: 415 Unsupported Media Type quando o corpo está vazio ou o Content-Type
  não é multipart/form-data; 400 Bad Request quando o campo file não é enviado.

  O contrato declara security: [] nesta operação; o JWT é injetado mesmo assim
  para as rotas que documentam 401 e para alinhar com o restante da bateria.

  Contexto:
    Dado que existe uma usuária autenticada para o módulo de upload

  # --- CENÁRIOS DE SUCESSO ---

  Cenário: Envia uma imagem válida no campo file
    Quando eu envio POST multipart de upload para "/upload/imagem" com o arquivo "teste-upload.png"
    Então a resposta da API de upload deve ter status 201
    E o JSON retornado deve corresponder exatamente ao contrato UploadResponseDto

  # --- CENÁRIOS DE FALHA (415 / 400) ---

  Cenário: Rejeita upload com corpo da requisição vazio
    Quando eu envio POST de upload para "/upload/imagem" com o corpo vazio
    Então a resposta da API de upload deve ter status 415

  Cenário: Rejeita upload sem o campo obrigatório file
    Quando eu envio POST multipart de upload para "/upload/imagem" sem o campo file
    Então a resposta da API de upload deve ter status 400
