# Elas Conectadas - Backend API

Este é o repositório do back-end do aplicativo Elas Conectadas, um projeto desenvolvido como Trabalho de Conclusão de Curso (TCC). O objetivo do sistema é criar uma rede de apoio e divulgação de serviços e produtos geridos exclusivamente por mulheres empreendedoras.

## A Filosofia Spec-Driven (Especificação por Contrato)

A API foi construída utilizando a arquitetura de Spec-Driven Development (SDD). Isso significa que a especificação (o contrato da aplicação em arquivos YAML via OpenAPI/Swagger) é tratada como a verdade absoluta do sistema. Nenhuma regra de negócio é implementada sem que seja definida de antemão no contrato. O código-fonte atua apenas como um executor fiel da especificação, garantindo que a comunicação seja perfeitamente previsível, segura e à prova de divergências de documentação.

## Tecnologias Utilizadas

* Framework Principal: NestJS
* Linguagem: TypeScript
* ORM (Banco de Dados): Prisma
* Banco de Dados: MySQL
* Documentação da API: Swagger / OpenAPI
* Autenticação: JWT (JSON Web Tokens)
* Armazenamento de Imagens em Nuvem: Cloudinary (Utilizado para receber uploads de fotos e gerar links leves, evitando a sobrecarga do banco de dados).

## Atualizando o Contrato e Iniciando o Servidor

Na nossa arquitetura, o servidor não deve rodar com um contrato desatualizado. Utilizamos comandos específicos para empacotar os arquivos YAML e levantar a aplicação:

* npm run build:spec : Comando responsável por ler os arquivos .yaml modulares (na pasta api-specs/) e empacotá-los num único arquivo mestre openapi-spec.json na raiz do projeto. Deve ser executado sempre que o contrato for atualizado.
* npm start : Comando básico para iniciar o servidor NestJS na sua versão compilada padrão, geralmente utilizado em ambientes de produção. Não possui recarregamento automático.
* npm run start:dev : Comando ideal para o desenvolvimento diário. Inicia o servidor com auto-reload ativado, recompilando o código instantaneamente após alterações.

## Validação e Testes (O Código obedecendo ao Contrato)

Nossa bateria de testes garante tanto o cumprimento das regras de negócio quanto a resiliência sob estresse.

### Cucumber (Testes de Comportamento - BDD)

O Cucumber valida de forma comportamental se as rotas estão obedecendo estritamente ao contrato YAML (rejeitando dados inválidos e processando os corretos com os devidos retornos previstos na especificação).

* Teste Total: npm run test:cucumber
  Executa a bateria completa de testes lendo todos os arquivos .feature do projeto. Ideal para rodar antes de efetuar novos commits, garantindo conformidade em todos os módulos.
* Teste Específico: npx cucumber-js features/nome-do-arquivo.feature
  Focado em um único domínio. Executa apenas os testes do arquivo especificado (ex: features/produtos.feature), agilizando o desenvolvimento enquanto o trabalho ocorre em um módulo específico sem necessidade de validar todo o sistema.

### k6 (Testes de Performance e Carga)

O k6 valida os requisitos não-funcionais da arquitetura, provando que o sistema suporta altos volumes de acesso sem degradar o tempo de resposta estipulado no contrato.

* Teste Total: npm run test:k6 (ou node load-tests/run-all.js)
  Roda todos os scripts de carga sequencialmente, estressando a API de forma global para avaliar a infraestrutura como um todo sob alta demanda.
* Teste Específico: k6 run load-test-produtos.js
  Roda um script de simulação isolado. Muito útil para refinar os limites de aceitação, mensurar a escalabilidade ou investigar gargalos em um endpoint recém-criado de forma isolada.