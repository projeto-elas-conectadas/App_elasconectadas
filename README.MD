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
  <img src="https://img.shields.io/badge/typescript-%23007ACC.svg?style=for-the-badge&logo=typescript&logoColor=white" alt="TypeScript" />
  <img src="https://img.shields.io/badge/Prisma-3982CE?style=for-the-badge&logo=Prisma&logoColor=white" alt="Prisma" />
  <img src="https://img.shields.io/badge/postgres-%23316192.svg?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL" />
  <br>
</details>

## Como iniciar o projeto localmente

Backend e frontend são configurados em terminais separados.

### 1. Backend

```bash
cd Elas_Conectadas_BackEnd
npm install
```

No diretório do backend, copie o arquivo de exemplo e preencha as credenciais locais (banco, chaves de API e demais variáveis):

```bash
cp .env.example .env
```

Sincronize o banco e inicie o servidor:

```bash
npx prisma migrate dev
npm run start:dev
```

### 2. Frontend (Flutter)

Em outro terminal:

```bash
cd Elas_Conectadas_FrontEnd
flutter pub get
```

Com um emulador (Android/iOS) em execução ou um dispositivo físico conectado via USB, rode o aplicativo:

```bash
flutter run
```

## Documentação

- [README do Backend](Elas_Conectadas_BackEnd/README.md)
- [README do Frontend](Elas_Conectadas_FrontEnd/README.md)
