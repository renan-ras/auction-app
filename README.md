# README

seeds.rb: Rodar rails db:reset ou **rails db:seed** para carregar a base de dados de exemplo.

Esboços que ajudaram a criar o projeto, mas não estão atualizados.

Projeto de Leilão - Planilha de Estudos
https://docs.google.com/spreadsheets/d/1zl_ZktyqOILeP_3NLTzAmE1udxIY7tqg9e3bY42rfFE/edit?usp=sharing


Gems adicionadas:
```ruby
group :test do
  gem 'database_cleaner'
end

gem "devise", "~> 4.9"
```

Foi usada a gem 'database_cleaner' devido a alguns problemas com persistência de dados durante os testes.

Devise para autenticação de usuários.