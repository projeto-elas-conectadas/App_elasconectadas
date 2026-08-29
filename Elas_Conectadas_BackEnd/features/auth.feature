# language: pt
Funcionalidade: Autenticação
  Validação de contrato OpenAPI dos endpoints de auth.

  # --- CENÁRIOS DE FALHA (Validação do Contrato de Entrada - 400) ---

  Cenário: Login rejeita corpo sem campos obrigatórios
    Quando eu envio POST para "/auth/login" com o corpo:
      """
      {}
      """
    Então a resposta deve ter status 400

  Cenário: Login rejeita e-mail inválido
    Quando eu envio POST para "/auth/login" com o corpo:
      """
      {"email": "nao-e-email", "password": "Senha123!"}
      """
    Então a resposta deve ter status 400

  Cenário: Send rejeita corpo sem e-mail
    Quando eu envio POST para "/auth/send" com o corpo:
      """
      {}
      """
    Então a resposta deve ter status 400

  Cenário: Request OTP rejeita e-mail inválido
    Quando eu envio POST para "/auth/request-otp" com o corpo:
      """
      {"email": "invalido"}
      """
    Então a resposta deve ter status 400

  Cenário: Verify OTP rejeita corpo incompleto
    Quando eu envio POST para "/auth/verify-otp" com o corpo:
      """
      {"email": "usuario@teste.com"}
      """
    Então a resposta deve ter status 400

  # --- CENÁRIOS DE SUCESSO (Validação do Contrato de Saída e Banco de Dados - 201) ---

  Cenário: Login efetuado com sucesso
    Dado que existe um usuário no banco com email "admin@elasconectadas.com" e senha "Senha123!"
    Quando eu envio POST para "/auth/login" com o corpo:
      """
      {
        "email": "admin@elasconectadas.com",
        "password": "Senha123!"
      }
      """
    Então a resposta deve ter status 201

  Cenário: Solicitação de envio de email com sucesso
    Quando eu envio POST para "/auth/send" com o corpo:
      """
      {
        "email": "admin@elasconectadas.com"
      }
      """
    Então a resposta deve ter status 201

  Cenário: Solicitação de OTP com sucesso
    Quando eu envio POST para "/auth/request-otp" com o corpo:
      """
      {
        "email": "admin@elasconectadas.com"
      }
      """
    Então a resposta deve ter status 201

  Cenário: Verificação de OTP com sucesso
    Dado que o usuário "admin@elasconectadas.com" possui o OTP "123456"
    Quando eu envio POST para "/auth/verify-otp" com o corpo:
      """
      {
        "email": "admin@elasconectadas.com",
        "otp": "123456"
      }
      """
    Então a resposta deve ter status 201