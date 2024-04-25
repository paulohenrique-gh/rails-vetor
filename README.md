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
Isso vai instalar todas as dependências necessárias, iniciar o banco de dados e servir a aplicação na porta 3000

Acesse a aplicação através do endereço http://localhost:3000

## Testes

Os testes foram escritos utilizando as gems [RSpec](https://github.com/rspec/rspec-rails) e [FactoryBot](https://github.com/thoughtbot/factory_bot_rails).

Para executar a suíte de testes, utilize o comando:
```shell
docker exec web-vetor rspec
```
Foi utilizada também a gem [SimpleCov](https://github.com/simplecov-ruby/simplecov) para monitorar a cobertura dos testes. A cobertura atual está em **100%**

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/b8ecb136-73e1-4b15-b71f-d2c79a3d83ee)

## Modelos de dados

Os dados foram modelados de acordo com o diagrama abaixo.

- `psychologist`: Representa o psicólogo
- `participant`: Representa o avaliado, que acessa instrumentos atribuídos pelo psicólogo
- `instrument`: Representa o instrumento psicológico
- `participant_instrument`: Representa a relação entre um avaliado e um instrumento
- `question`: Representa uma questão no instrumento
- `option`: Representa uma opção de uma questão
- `answer`: Representa a resposta do avaliado a uma questão

Foi utilizado o dbdocs para documentar o schema do banco de dados nos links abaixo:

- https://dbdiagram.io/d/Vetort-b-6625216503593b6b618cf40a
- https://dbdocs.io/phenrique.menoli/Vetor

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/d741f994-9b3c-4132-90f0-4032613aa22b)

## Funcionalidades

A aplicação inicia com dados pré-cadastrados. Você pode testar as funcionalidades utilizando os dados abaixo: 
Psicólogo:
    - E-mail: user@email.com
    - Senha: password
Esse usuário já possui 3 avaliados cadastrados, cada um com um instrumento finalizado e outro pendente.

Se quiser cadastrar outro avaliado, pode usar os dados fictícios abaixo:
Novo avaliado:
    - Nome: Sasha Levy
    - CPF: 30902403001
    - E-mail: waravor@mailinator.com
    - Data de nascimento: 13/05/1975

Link para visualização do e-mail enviado ao atribuir instrumento: http://localhost:3000/rails/mailers/participant_instrument_mailer/notify_participant 

### Autenticação

O psicólogo se cadastra na plataforma informando e-mail e senha.

Depois disso, o psicólogo consegue fazer o login e utilizar o restante das funcionalidades

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/c71f210d-f603-4fde-ae10-7b19992fe7fb)

### Cadastro de avaliado

Rota: `participants/new`

O psicólogo autenticado consegue cadastrar avaliado informando nome, cpf, e-mail e data de nascimento, a partir de link na página inicial ou na navbar.

Foi utilizada a gem [cpf_cnpj](https://github.com/fnando/cpf_cnpj) para ajudar na validação e permitir somente CPF válido. Para gerar CPF fictício válido, recomenda-se o site https://www.4devs.com.br/gerador_de_cpf.

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/f1f382f6-d33e-4ecd-a2e0-7ff9c973f2bb)

### Página de detalhes de um avaliado

Rota: `participants/:id`

O psicólogo autenticado consegue acessar a página de detalhes de um avaliado clicando no nome correspondente na lista de avaliados na página inicial.
A página tem uma lista dos instrumentos aplicados no avaliado.

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/79a9c7ca-eb0d-49c6-8297-aec4b57ff415)

### Psicólogo aplica instrumento em um avaliado

Rota: `participants/:id`

Na mesma página de detalhes de um avaliado, o psicólogo tem acesso aos instrumentos disponíveis, e pode escolher de uma lista o instrumento a ser aplicado

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/98847b3e-3c01-4a6f-87b9-f728e56485dd)

### Envio de e-mail ao avaliado

Quando o psicólogo aplica o instrumento, é enviado e-mail ao avaliado contendo o link para acesso ao instrumento.
É possível acessar uma prévia do email no link http://localhost:3000/rails/mailers/participant_instrument_mailer/notify_participant.
A aplicação foi configurada para carregar uma prévia do e-mail enviado para o avaliado com instrumento atribuído mais recentemente.

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/17e6d8ad-811d-4752-aaf8-27e981beca90)

### Avaliado é direcionado para o sistema através do link recebido por e-mail

Rota da validação: `participant_instruments/:participant_instrument_id/validation`

Ao clicar no link recebido, o avaliado é direcionado para a página de validação se os dados ainda não tiverem sido preenchidos. Após preenchimento dos dados, o avaliado é direcionado para a página com as questões do instrumento.

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/14fe412d-fb52-409b-877c-0ac1dd0b2205)

### Avaliado acessa instrumento após preencher os dados corretamente

Rota do questionário: `participant_instruments/:participant_instrument_id/questionnaire`

Após confirmação dos dados na página de validação, o avaliado é direcionado para a página do instrumento.
O instrumento é um questionário com 5 perguntas e 4 alternativas possíveis. A primeira alternativa soma 3 pontos ao resultado, a segunda soma 2 pontos, a terceira soma 1 ponto e a quarta não soma ponto.
O resultado do instrumento fica disponível somente para o psicólogo.

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/c85c9d77-c0c0-4bab-b58a-0f0e303a8a5b)

### Psicólogo acessa página com o resultado de um instrumento

Rota da página de resultados: `participant_instruments/:participant_instrument_id/results`

A partir do link "Detalhes" correspondente a um instrumento na página de um avaliado, o psicólogo autenticado tem acesso à página com os resultados do instrumento.
A página tem um resumo das informações do instrumento, a pontuação total, as questões do instrumento e as respostas do avaliado.

![image](https://github.com/paulohenrique-gh/rails-vetor/assets/124916478/8d9b297f-2926-465d-85eb-eab01e622ebb)
