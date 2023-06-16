# Usuários administradores podem registrar um bloqueio para CPF. Um CPF bloqueado não pode se cadastrar no sistema. Caso já possua cadastro, ao fazer login deve ser exibida uma mensagem informando que sua conta está suspensa. Usuários com CPF bloqueado não podem fazer lances em leilões nem enviar novas dúvidas para um lote.

require 'rails_helper'

context 'Admin' do
  it 'faz bloqueio' do
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')

    login_as admin_a
    visit root_path
    click_on 'Bloqueios'
    click_on 'Novo Bloqueio'
    fill_in 'CPF',	with: '12146825618'
    fill_in 'Motivo',	with: 'Usuário problemático'
    click_on 'Enviar'
    expect(page).to  have_content 'CPF bloqueado com sucesso'
    expect(page).to  have_content '12146825618'
    expect(page).to  have_content 'Usuário problemático'

    # expect(page).to  have_content 'banana'
  end
end

context 'Usuário bloqueado' do
  it 'tenta se cadastrar' do
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    block = BlockedCpf.create!(cpf: '12146825618', reason: 'Usuário problemático', blocked_by: admin_a)
    visit root_path
    click_on 'Entrar'
    click_on 'Sign up'
    fill_in 'Apelido',	with: 'albert90'
    fill_in 'Cpf',	with: '12146825618'
    fill_in 'E-mail',	with: 'alberto@leilaodogalpao.com.br'
    fill_in 'Senha',	with: '123456'
    fill_in 'Confirme sua senha',	with: '123456'
    click_on 'Sign up'

    expect(page).to  have_content 'Olá visitante!'
    expect(page).to  have_content 'Não foi possível salvar usuário'
    expect(page).to  have_content 'Este CPF está bloqueado'

    # expect(page).to  have_content 'banana'
  end

  it 'tenta logar' do
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    user_a = User.create!(nickname: 'albert90', email: 'alberto@qqcoisa.com.br', password: '123456', cpf: '12146825618')
    block = BlockedCpf.create!(cpf: '12146825618', reason: 'Usuário problemático', blocked_by: admin_a)
    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail',	with: 'alberto@qqcoisa.com.br'
    fill_in 'Senha',	with: '123456'
    click_on 'Log in'

    expect(page).to  have_content 'Olá visitante!'
    expect(page).to  have_content 'Sua conta está suspensa'
  end
end
