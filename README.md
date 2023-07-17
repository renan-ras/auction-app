# App Leilões

<p align="center">
  <img src="http://img.shields.io/static/v1?label=Ruby&message=3.2.2&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=Ruby%20On%20Rails%20&message=7.0.4.3&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=TESTES&message=%3E100&color=GREEN&style=for-the-badge"/>
  <img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/>
</p>

### Tópicos 

:small_blue_diamond: [Descrição do projeto](#descrição-do-projeto)

:small_blue_diamond: [Funcionalidades](#principais-funcionalidades)

:small_blue_diamond: [Pré-requisitos](#pré-requisitos)

:small_blue_diamond: [Setup](#como-rodar-a-aplicação)

:small_blue_diamond: [Dados de acesso](#dados-de-acesso---seeds)

## Descrição do projeto
Leilão de itens que podem apresentar algum tipo de avaria. Mesmo que sejam do mesmo modelo, cada item é único e terá seu próprio cadastro, descrição, fotos e código.

Um lote agrupa um ou vários itens e estabelece o lance mínimo para o lote, o incremento mínimo entre lances e as datas de início e término. Para que um lote se torne um leilão disponível para os usuários regulares, ele precisa ser aprovado por um administrador diferente daquele que criou o lote.

Assim que um lote é aprovado, o leilão e seus itens ficam disponíveis para visualização na seção 'Leilões Futuros'. Usuários regulares cadastrados já podem adicionar esses lotes aos seus favoritos, fazer perguntas e visualizar perguntas de outros usuários, bem como as respostas dos administradores (a menos que um administrador decida ocultar uma pergunta). Quando a data de início do leilão chega, ele é movido para a seção de 'Leilões em Andamento' e já pode receber lances dos usuários regulares.

Ao término do prazo do leilão, o administrador irá validar seu resultado, autorizando a venda para o maior lance ou cancelando o leilão caso não haja lances. Este processo não é automático, devido a um requisito do projeto. Os itens de leilões cancelados voltam a estar disponíveis para outros leilões.

Os usuários podem visualizar em seu próprio painel os leilões dos quais participaram, aqueles que ganharam e os que adicionaram aos favoritos.

## Principais Funcionalidades
* **Cadastro de usuários regulares e administradores**

* **Cadastro de itens e lotes**

* **Definição de lance mínimo e incremento mínimo entre lances**

* **Aprovação de lotes por um segundo admin**

* **Envio de lances por usuários cadastrados (enquanto leilão estiver em andamento)**  
  <details>
  <summary>Ver imagem</summary>

  ![Screenshot from 2023-07-07 15-44-01](https://github.com/renan-ras/auction-app/assets/126360032/b4d8abdd-85df-4c47-a2dd-26a4c4bed71d)
  </details>
  
* **Perguntas e respostas em cada lote para usuários cadastrados**

* **Admin visualiza todas as perguntas em seu painel**
  <details>
  <summary>Ver imagem</summary>

  ![Screenshot from 2023-07-17 16-52-53](https://github.com/renan-ras/auction-app/assets/126360032/35732004-aebb-48d7-9f93-19fcec8e4166)

  </details>

* **Usuário cadastrado pode favoritar lotes**

* **Painel de usuário com lotes favoritos, participados e arrematados**  
  <details>
  <summary>Ver imagem</summary>

  ![Screenshot from 2023-07-17 15-27-19](https://github.com/renan-ras/auction-app/assets/126360032/a39d7c71-85ee-4f4a-bba9-386aabd17281)
  </details>
  
* **Painel de administradores com tarefas pendentes**  
  <details>
  <summary>Ver imagem</summary>

  ![Screenshot from 2023-07-17 15-14-22](https://github.com/renan-ras/auction-app/assets/126360032/9143071a-08d1-4b20-aefb-172a0698b4ed)
  </details>

* **Busca de lotes por código ou nome de item**
  <details>
  <summary>Ver imagem</summary>

  ![Screenshot from 2023-07-17 16-20-14](https://github.com/renan-ras/auction-app/assets/126360032/2f89c8ae-e6b5-423a-8f61-1511fcc104eb)
  </details>

* **Bloqueio por CPF de usuário cadastrado ou não**
  <details>
  <summary>Ver imagem</summary>

  ![Screenshot from 2023-07-17 16-37-10](https://github.com/renan-ras/auction-app/assets/126360032/de0e5d26-fb94-4b5d-bd67-8475c99c5f23)
  </details>

* **Leilões sem lances são cancelados e itens voltam a estar disponíveis para outros leilões**


## Pré-requisitos

:warning: [Ruby: versão 3.2.2](https://www.ruby-lang.org/en/downloads/)

:warning: [Ruby on Rails: versão 7.0.4.3](https://rubygems.org/gems/rails/versions/7.0.4.3)

:warning: [SQLite3: versão 1.4](https://www.sqlite.org/download.html)

:warning: [Node](https://nodejs.org/en/download/)

## Como rodar a aplicação

No terminal, clone o projeto:

```sh
git clone https://github.com/renan-ras/auction-app.git
```

Entre na pasta do projeto:

```sh
cd auction-app
```

Comando para configuração inicial (isso já carrega os seeds)

```sh
./bin/setup
```
Rodando aplicação

```sh
rails server
```
Acesse a aplicação em seu navegador através do endereço http://localhost:3000

## Dados de acesso - seeds

| Papel   | E-mail                           | nickname   | password | CPF         |
|---------| ---------------------------------|------------| -------- |-------------|
| Admin   | skywalker@leilaodogalpao.com.br  | Ad_joao_cc | 123456   | 56086147396 |
| Admin   | debs@leilaodogalpao.com.br       | Ad_debora  | 123456   | 25488078274 |
| Admin   | bruh@leilaodogalpao.com.br       | Ad_bruna   | 123456   | 31290135983 |
| Regular | gaucho@email.com.br              | Ronaldinho | 123456   | 42513565606 |
| Regular | joao7@email.com.br               | Joao       | 123456   | 63833236442 |
| Regular | manu@email.com.br                | Manoela    | 123456   | 59113983709 |
| Regular | dada@email.com.br                | Darci      | 123456   | 56896226722 |
| Regular | lang@email.com.br                | Lana       | 123456   | 44811903706 |
| Regular | renan@campuscode.com.br          | Renan      | 123456   | 06871624163 |

Obs.: Admin foi definido como qualquer usuário que se cadastre com um email de domínio *'leilaodogalpao.com.br'*

## Como rodar os testes

Para execução dos testes, execute o comando abaixo:

```sh
rspec
```
