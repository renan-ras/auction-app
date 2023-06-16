# Usuários administradores devem se cadastrar na plataforma usando e-mails do domínio "@leilaodogalpao.com.br". Além disso, devem ser informados uma senha e o CPF do usuário. Os CPFs devem ser únicos e válidos.

require 'rails_helper'

describe 'Usuário tenta se cadastrar' do
  context 'como administrador' do
    it 'e tem sucesso' do
      visit root_path
      click_on 'Entrar'
      click_on 'Sign up'
      fill_in 'Apelido',	with: 'albert90'
      fill_in 'Cpf',	with: '69142235219'
      fill_in 'E-mail',	with: 'alberto@leilaodogalpao.com.br'
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      click_on 'Sign up'
      expect(page).to  have_content 'Olá admin! albert90 (alberto@leilaodogalpao.com.br)'
      expect(page).to  have_content 'Bem vindo! Você realizou seu registro com sucesso'
    end

    it 'mas erra o email e vira usuário comum' do
      visit root_path
      click_on 'Entrar'
      click_on 'Sign up'
      fill_in 'Apelido',	with: 'albert90'
      fill_in 'Cpf',	with: '69142235219'
      fill_in 'E-mail',	with: 'alberto@leiladogalpao.com.br' # Email Não Admin: Faltou uma letra
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      click_on 'Sign up'
      expect(page).to  have_content 'Olá usuário! albert90 (alberto@leiladogalpao.com.br)'
      expect(page).to  have_content 'Bem vindo! Você realizou seu registro com sucesso'
    end

    it 'mas informa um CPF inválido' do
      visit root_path
      click_on 'Entrar'
      click_on 'Sign up'
      fill_in 'Apelido',	with: 'albert90'
      fill_in 'Cpf',	with: '69142235215'
      fill_in 'E-mail',	with: 'alberto@leilaodogalpao.com.br'
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      click_on 'Sign up'
      expect(page).to  have_content 'Olá visitante!'
      expect(page).to  have_content 'Não foi possível salvar usuário'
      expect(page).to  have_content 'Cpf não é válido'
    end

    it 'mas informa um CPF repetido' do
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')

      visit root_path
      click_on 'Entrar'
      click_on 'Sign up'
      fill_in 'Apelido',	with: 'albert90'
      fill_in 'Cpf',	with: '69142235219'
      fill_in 'E-mail',	with: 'alberto@leilaodogalpao.com.br'
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      click_on 'Sign up'
      expect(page).to  have_content 'Olá visitante!'
      expect(page).to  have_content 'Não foi possível salvar usuário'
      expect(page).to  have_content 'Cpf já está em uso'
    end

    it 'consegue; faz logout e login' do
      # Arrange - Consegue de cadastrar
      visit root_path
      click_on 'Entrar'
      click_on 'Sign up'
      fill_in 'Apelido',	with: 'albert90'
      fill_in 'Cpf',	with: '69142235219'
      fill_in 'E-mail',	with: 'alberto@leilaodogalpao.com.br'
      fill_in 'Senha',	with: '123456'
      fill_in 'Confirme sua senha',	with: '123456'
      click_on 'Sign up'
      expect(page).to have_content 'Olá admin! albert90 (alberto@leilaodogalpao.com.br)'

      # Act - faz logout e login
      click_on 'Sair'
      expect(page).to  have_content 'Olá visitante!'
      expect(page).to  have_content 'Logout efetuado com sucesso'

      click_on 'Entrar'
      fill_in 'E-mail',	with: 'alberto@leilaodogalpao.com.br'
      fill_in 'Senha',	with: '123456'
      click_on 'Log in'

      # Assert - Visualiza as informações de sucesso
      expect(page).to  have_content 'Olá admin! albert90 (alberto@leilaodogalpao.com.br)'
      expect(page).to  have_content 'Login efetuado com sucesso'
    end
  end
end
