<div align="center">

# Elas Conectadas

*Uma rede social dedicada a conectar, fortalecer e impulsionar mulheres empreendedoras.*

</div>

---

## Sobre o Projeto

O **Elas Conectadas** nasce com o propósito de criar um ecossistema digital focado no empreendedorismo feminino. Mais do que uma vitrine de produtos, a plataforma funciona como um hub de networking: empreendedoras podem divulgar seus trabalhos, descobrir novos negócios e formar parcerias estratégicas.

A ideia central é transformar a concorrência em colaboração, permitindo troca de informações, compra e venda de produtos e o fortalecimento mútuo entre mulheres do mercado.

## Principais Funcionalidades

- **Exposição de produtos** — vitrine digital para cadastrar e apresentar produtos e serviços.
- **Conexão e parcerias** — rede social para conectar perfis com interesses em comum, facilitando collabs e parcerias de negócios.
- **Troca de informações** — espaço de networking para experiências, dicas de gestão e fortalecimento da comunidade.
- **Negócios** — ambiente para compra e venda direta dos produtos expostos.

## Contexto do Projeto

O projeto “El@s Conectadas” originou-se no âmbito acadêmico como um projeto de extensão apoiado pelo **Programa Empoderamento e Liderança de Mulheres — Universidade Sem Fronteiras**. O objetivo inicial era capacitar e conectar empreendedoras e lideranças femininas na produção e divulgação de produtos e serviços pelas mídias.

Com a execução do projeto de extensão, verificou-se a necessidade de um aplicativo que apoiasse a comunicação direta e o fomento do empreendedorismo feminino local na região de Bandeirantes-PR. O grupo de pesquisa *Informática Aplicada*, por meio de trabalhos de Iniciação Científica, iniciou o desenvolvimento do aplicativo Elas Conectadas.

Este trabalho dá continuidade às pesquisas anteriores, pelas quais foram desenvolvidos o protótipo da interface (front-end) e a base inicial do back-end, voltadas ao fortalecimento do empreendedorismo de pequeno porte.

Atualmente, **o projeto continua a ser desenvolvido e aprimorado na Universidade Estadual do Norte do Paraná (UENP)** por meio de Trabalhos de Conclusão de Curso (TCC), projetos de Iniciação Científica (PIBIC) e outras iniciativas de pesquisa.

## Tecnologias Utilizadas

<details>
  <summary><b>Frontend (aplicativo mobile)</b></summary>
  <br>
  <img src="https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <br>
</details>

<details>
  <summary><b>Backend (API REST)</b></summary>
  <br>
  <img src="https://img.shields.io/badge/nestjs-%23E0234E.svg?style=for-the-badge&logo=nestjs&logoColor=white" alt="NestJS" />
  <img src="https://img.shields.io/badge/node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white" alt="Node.js" />
  <img src="https://img.shields.io/badge/yarn-2C8EBB?style=for-the-badge&logo=yarn&logoColor=white" alt="Yarn" />
  <img src="https://img.shields.io/badge/typescript-%23007ACC.svg?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript" />
  <img src="https://img.shields.io/badge/Prisma-3982CE?style=for-the-badge&logo=Prisma&logoColor=white" alt="Prisma" />
  <img src="https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white" alt="MySQL" />
  <br>
</details>

## Requisitos de software

Instale estes programas na máquina antes de abrir o projeto. O backend sobe com Node.js e Yarn, falando com um MySQL instalado localmente.

| Ferramenta | Versão | Para quê |
| --- | --- | --- |
| Git | atual | clonar o repositório |
| Node.js | 20 LTS | executar a API NestJS |
| Yarn | 1.22 (Classic) | instalar dependências e rodar os scripts do backend |
| MySQL | 8 | banco de dados da API |
| Flutter | stable, Dart `>=3.0.0 <4.0.0` | aplicativo mobile |

O Yarn 1 acompanha o Node 20 pelo Corepack. No PowerShell, depois de instalar o Node:

```powershell
corepack enable
corepack prepare yarn@1.22.22 --activate
yarn --version
```

O comando `yarn --version` deve imprimir `1.22.22`.

Confira também:

```powershell
node --version
```

A saída esperada começa com `v20`.

## Backend — configurar e executar

Abra um terminal na pasta do repositório.

### 1. Entrar na API e instalar as dependências

```powershell
cd Elas_Conectadas_BackEnd
yarn install
```

O Yarn usa o arquivo `yarn.lock`. Esse comando cria a pasta `node_modules`.

### 2. Criar o banco no MySQL

Com o serviço do MySQL em execução, crie um banco vazio. No cliente `mysql`:

```sql
CREATE DATABASE elas_conectadas CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

Anote o usuário, a senha e o nome do banco. O usuário precisa de permissão nesse banco.

### 3. Preencher as variáveis de ambiente

Copie o exemplo e edite os valores reais:

```powershell
copy .env.example .env
```

No Linux ou no macOS o equivalente é `cp .env.example .env`.

O arquivo `.env` fica só na sua máquina. Ele não vai para o GitHub. Preencha:

| Variável | O que colocar |
| --- | --- |
| `API_HOST` | `0.0.0.0` para a API aceitar conexões de outras máquinas. `127.0.0.1` deixa a API apenas neste computador. |
| `API_PORT` | `8080`. É a porta do Nest. Não use `PORT` para a API. |
| `PUBLIC_URL` | `https://elasconectadas.labcct.net.br` em produção. No seu computador pode deixar `http://127.0.0.1:8080`. |
| `DB_USER`, `DB_PASSWORD`, `DB_NAME` | usuário, senha e nome do banco que você criou. |
| `DATABASE_URL` | connection string do Prisma, no formato `mysql://usuario:senha@localhost:3306/nome_do_banco`. |
| `JWT_SECRET` | uma frase longa e aleatória, diferente em cada ambiente. |
| `EMAIL_HOST`, `PORT`, `EMAIL_USER`, `EMAIL_PASSWORD` | SMTP. `PORT` aqui é a porta do e-mail (em geral `587`), não a da API. |
| `CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, `CLOUDINARY_API_SECRET` | conta Cloudinary, usada no upload de imagens. |

### 4. Criar as tabelas e gerar o cliente do Prisma

```powershell
yarn prisma migrate dev
```

Esse comando aplica as migrations e gera o cliente que o Nest importa. Se as tabelas já existirem e você só precisar do cliente:

```powershell
yarn prisma generate
```

### 5. Subir a API em modo de desenvolvimento

```powershell
yarn start:dev
```

Antes de escutar, esse script confere o contrato OpenAPI (`yarn check:spec`) e gera o `openapi-spec.json` (`yarn build:spec`).

Quando o terminal mostrar a API escutando, abra:

- nesta máquina: `http://127.0.0.1:8080`
- documentação Swagger: `http://127.0.0.1:8080/api`

Para encerrar, use `Ctrl+C` nesse terminal.

### 6. Subir a API como no servidor

No servidor de produção o processo não fica em modo watch. Na pasta do backend:

```powershell
yarn install
yarn prisma generate
yarn build
yarn start:prod
```

`yarn build` gera a pasta `dist`. `yarn start:prod` executa `node dist/main`. A API continua escutando em `API_HOST` e `API_PORT` (padrão `0.0.0.0:8080`). O endereço público `https://elasconectadas.labcct.net.br` é o proxy HTTPS na porta 443, que encaminha até esse processo.

## Testes do backend

Com as dependências instaladas, na pasta `Elas_Conectadas_BackEnd`:

```powershell
yarn test
```

Esse é o Jest: regras de negócio e o contrato OpenAPI, sem precisar do MySQL no ar.

O Cucumber chama a API já ligada em `http://127.0.0.1:8080`. Suba `yarn start:dev` em outro terminal e então:

```powershell
yarn test:cucumber
```

Os testes de carga (k6) também exigem a API no ar. Eles entram quando a mudança é de desempenho:

```powershell
yarn test:k6
```

## Frontend (Flutter)

A URL da API de produção está em `Elas_Conectadas_FrontEnd/lib/core/config/app_config.dart`:

`https://elasconectadas.labcct.net.br`

Em outro terminal, na raiz do repositório:

```powershell
cd Elas_Conectadas_FrontEnd
flutter pub get
flutter run
```

`flutter run` pede um emulador Android/iOS ou um celular conectado por USB.

Para gerar o APK de release (o arquivo que vai na Release do GitHub):

```powershell
flutter build apk --release
```

O APK fica em `Elas_Conectadas_FrontEnd/build/app/outputs/flutter-apk/app-release.apk`.

Os testes do app:

```powershell
flutter test
```

## O que o GitHub verifica sozinho

Cada pull request para a branch `main` dispara o workflow `.github/workflows/ci.yml`. Ele instala o backend com Yarn, roda `yarn test` e `yarn build`, e no app roda `flutter test`. O merge na `main` espera esses passos passarem. Cucumber e k6 continuam manuais, porque precisam da API e do banco ligados.

## Documentação

- [README do Backend](Elas_Conectadas_BackEnd/documentos/README.md)
- [README do Frontend](Elas_Conectadas_FrontEnd/README.md)
