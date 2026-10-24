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
* Dependências e scripts: Yarn 1.22 (Classic). O passo a passo de instalação, MySQL e variáveis de ambiente está no [README da raiz](../../README.MD).

## Atualizando o Contrato e Iniciando o Servidor

Na nossa arquitetura, o servidor não deve rodar com um contrato desatualizado. Utilizamos comandos específicos para empacotar os arquivos YAML e levantar a aplicação:

* `yarn build:spec`: lê os arquivos `.yaml` modulares (na pasta `api-specs/`) e empacota o `openapi-spec.json` na raiz do backend. Rode sempre que o contrato for atualizado.
* `yarn start`: inicia o Nest já compilado, no mesmo modo usado quando não se quer o recarregamento automático.
* `yarn start:dev`: uso diário. Confere o contrato, regenera o `openapi-spec.json` e sobe o servidor com auto-reload.
* `yarn build` e `yarn start:prod`: compilam para `dist/` e sobem o processo como no servidor (`node dist/main`).

## Validação e Testes (O Código obedecendo ao Contrato)

Nossa bateria de testes garante tanto o cumprimento das regras de negócio quanto a resiliência sob estresse.

### Cucumber (Testes de Comportamento - BDD)

O Cucumber valida de forma comportamental se as rotas estão obedecendo estritamente ao contrato YAML (rejeitando dados inválidos e processando os corretos com os devidos retornos previstos na especificação).

* Teste total: `yarn test:cucumber`
  Executa a bateria completa lendo todos os arquivos `.feature`. A API precisa estar em `http://127.0.0.1:8080`. Rode antes de novos commits quando a mudança for de rota ou contrato.
* Teste específico: `yarn cucumber-js features/nome-do-arquivo.feature`
  Focado em um único domínio (exemplo: `features/produtos.feature`).

### k6 (Testes de Performance e Carga)

O k6 valida os requisitos não-funcionais da arquitetura, provando que o sistema suporta altos volumes de acesso sem degradar o tempo de resposta estipulado no contrato.

* Teste total: `yarn test:k6`
  Roda todos os scripts de carga em sequência. A API precisa estar no ar. Use quando a mudança for de desempenho.
* Teste específico: `yarn test:k6:produtos` (também existem `test:k6:auth`, `test:k6:ads`, `test:k6:posts`, `test:k6:upload` e `test:k6:users`).

Os testes de regra de negócio, que não precisam do banco, são `yarn test`.