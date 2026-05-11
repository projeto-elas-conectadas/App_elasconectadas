# design e engenharia reversa

swagger-autogen: Gera o JSON/YAML automaticamente lendo seus arquivos de rota.

Instalação: npm install --save-dev swagger-autogen

Stoplight Studio: Não é uma dependência do projeto, mas um software (GUI) para você editar o YAML visualmente. É indispensável para o "trabalho científico" de padronização que você mencionou.


# Governança (Linter de Spec)

Para garantir que seu contrato segue as boas práticas (como ter descrições, tipos definidos e padrões REST).

Spectral: O padrão da indústria para linting de documentos OpenAPI/AsyncAPI.

Instalação (CLI): npm install -g @stoplight/spectral-cli

Uso: Você cria um arquivo .spectral.yaml com as regras e roda spectral lint openapi.yaml.

# Mocking (Paralelismo)

Para que o front-end não dependa da sua lógica de banco de dados estar pronta.

Prism: Cria um servidor HTTP fake baseado no seu arquivo OpenAPI. Se você definiu que o /users retorna um objeto com nome e email, o Prism entregará isso automaticamente.

Instalação: npm install -g @stoplight/prism-cli

Comando: prism mock openapi.yaml

# Implementação e Validação (A Blindagem)

Aqui é onde o contrato "manda" no código.

express-openapi-validator: O middleware que intercepta as requisições.

Instalação: npm install express-openapi-validator

Por que usar? Se você definiu no YAML que a senha deve ter no mínimo 8 caracteres e o usuário enviar 5, o middleware mata a requisição com um 400 Bad Request antes mesmo de chegar no seu controller.

openapi-typescript: Como você tem background em Java e gosta de tipagem, essa ferramenta é obrigatória. Ela gera as Interfaces do TypeScript direto do YAML.

Instalação: npm install --save-dev openapi-typescript

Uso: npx openapi-typescript openapi.yaml -o ./src/types/schema.ts

# mudança de gerado de spec

por conta do projeto nao ser java script puro o swagger nao funciona bem com nestjs entao vou migrar para uma ferramenta propria do nest

### O Jeito NestJS de Extrair o Contrato