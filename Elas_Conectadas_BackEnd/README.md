# Elas Conectadas - Backend API

![NestJS](https://img.shields.io/badge/nestjs-%23E0234E.svg?style=for-the-badge&logo=nestjs&logoColor=white)
![Prisma](https://img.shields.io/badge/Prisma-3982CE?style=for-the-badge&logo=Prisma&logoColor=white)
![MySQL](https://img.shields.io/badge/mysql-%2300f.svg?style=for-the-badge&logo=mysql&logoColor=white)
![TypeScript](https://img.shields.io/badge/typescript-%23007ACC.svg?style=for-the-badge&logo=typescript&logoColor=white)
![Swagger](https://img.shields.io/badge/-Swagger-%23Clojure?style=for-the-badge&logo=swagger&logoColor=white)
![Cloudinary](https://img.shields.io/badge/Cloudinary-3448C5?style=for-the-badge&logo=Cloudinary&logoColor=white)

Este é o repositório do back-end do aplicativo **Elas Conectadas**, um projeto desenvolvido como Trabalho de Conclusão de Curso (TCC). O objetivo do sistema é criar uma rede de apoio e divulgação de serviços e produtos geridos exclusivamente por mulheres empreendedoras.

A API foi construída utilizando a arquitetura de **Spec-Driven Development (SDD)**, garantindo que o contrato de comunicação entre o aplicativo (Front-end) e o servidor (Back-end) seja claro, previsível e bem documentado.

## 🛠️ Tecnologias Utilizadas

* **Framework Principal:** [NestJS](https://nestjs.com/)
* **Linguagem:** TypeScript
* **ORM (Banco de Dados):** [Prisma](https://www.prisma.io/)
* **Banco de Dados:** MySQL
* **Documentação da API:** Swagger / OpenAPI
* **Autenticação:** JWT (JSON Web Tokens)
* **Armazenamento de Imagens em Nuvem:** [Cloudinary](https://cloudinary.com/) (Utilizado para receber uploads de fotos e gerar links leves, evitando a sobrecarga do banco de dados).

## 📚 Documentação Oficial das Tecnologias

Para facilitar o desenvolvimento, estudos e futuras manutenções por outras equipes, consulte as documentações oficiais das ferramentas base deste projeto:

* **NestJS:** [Guia Oficial do NestJS](https://docs.nestjs.com/)
* **Prisma ORM:** [Documentação do Prisma](https://www.prisma.io/docs/)
* **Cloudinary (Integração Node.js):** [Documentação SDK Node](https://cloudinary.com/documentation/node_integration)
* **Swagger no NestJS:** [Módulo OpenAPI/Swagger](https://docs.nestjs.com/openapi/introduction)
* **TypeScript:** [Handbook do TypeScript](https://www.typescriptlang.org/docs/)
* **Nodemailer (Serviço de E-mail):** [Documentação do Nodemailer](https://nodemailer.com/about/)

## ⚙️ Como Rodar o Projeto Localmente

Siga as instruções abaixo para testar o servidor em sua máquina.

### 1. Pré-requisitos
* Ter o [Node.js](https://nodejs.org/) instalado.
* Ter um servidor MySQL rodando localmente (ex: XAMPP, WAMP, ou Docker).
* Ter uma conta no [Cloudinary](https://cloudinary.com/) (para gerenciar os uploads de imagem).

### 2. Instalação
Clone este repositório e instale as dependências:

```bash
# Clone o repositório
git clone [https://github.com/Pauloluzkk/App_elasconectadas.git](https://github.com/Pauloluzkk/App_elasconectadas.git)

# Entre na pasta do backend
cd Elas_Conectadas_BackEnd

# Instale os pacotes necessários
npm install