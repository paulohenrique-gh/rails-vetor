# Desafio Vetor

Uma plataforma que permite que psicólogos disponibilizem instrumentos psicológicos para os avaliados de forma online.

## Principais tecnologias utilizadas

- Ruby 3.3.0
- Ruby On Rails 7.1.3
- Bootstrap
- PostgreSQL
- Docker

## Executando a aplicação

Clone o repositório e entre no diretório da aplicação:

```shell
git clone git@github.com:paulohenrique-gh/rails-vetor.git
```
```shell
cd rails-vetor
```

Com o [Docker](https://www.docker.com/get-started/) instalado, execute o comando abaixo para iniciar a aplicação:

```shell
docker compose up
```
Isso vai instalar todas as dependências necessárias e iniciar o servidor na porta 3000

Acesse a aplicação através do endereço http://localhost:3000

---

Alternativamente, você pode iniciar a aplicação sem Docker. Para isso, é necessário ter instalados localmente Ruby 3.3.0 e Ruby On Rails 7.1.3, além do PostgreSQL, e executar os comandos:

```shell
bin/setup
```
```shell
rails server
```

## Testes

Os testes foram escritos utilizando as gems [RSpec](https://github.com/rspec/rspec-rails) e [FactoryBot](https://github.com/thoughtbot/factory_bot_rails).

Para executar a suíte de testes, utilize o comando:
```shell
docker exec web rspec
```

Se estiver executando sem Docker:
```shell
rspec
```

## Modelos de dados

Os dados foram modelados de acordo com o diagrama abaixo.

- `psychologist`: Representa o psicólogo
- `participant`: Representa o avaliado, que acessa instrumentos atribuídos pelo psicólogo
- `instrument`: Representa o instrumento psicológico
- `participant_instrument`: Representa a relação entre um avaliado e um instrumento
- `question`: Representa uma questão no instrumento
- `option`: Representa uma opção de uma questão
- `answer`: Representa a resposta do avaliado a uma questão

Foi utilizado o dbdocs para documentar o schema do banco de dados. Você pode visualizar neste link: https://dbdocs.io/phenrique.menoli/Vetor

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/d741f994-9b3c-4132-90f0-4032613aa22b)


