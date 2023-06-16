# Um usuário autenticado, não administrador, pode fazer uma pergunta sobre um lote. Usuários administradores devem ter acesso a uma área para ver as perguntas sem respostas e respondê-las. As respostas devem ser vinculadas ao usuário administrador autenticado no momento. Usuários e visitantes devem ser capazes de ver as perguntas e as eventuais respostas em cada lote. Um administrador pode decidir ocultar uma pergunta, caso considere que a pergunta infringe o código de conduta do site ou possua termos ofensivos, por exemplo. Perguntas ocultas não devem ser exibidas para usuários nem para visitantes.

require 'rails_helper'

describe 'Em lote aprovado usuário' do
  it 'autenticado faz pergunta' do
    ###
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                           cpf: '30448522500')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')

    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_date_a = 1.day.from_now,
                        end_date: end_date_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
    lot_a.update(status: :approved, approver: admin_b)

    ###
    login_as user_a
    visit root_path
    click_on lot_a.code
    fill_in 'question_content',	with: 'Esse suporte serve no Samsung s10?' # Esse campo só aparece para usuário autenticado não-admin, conforme será mostrado em outros testes
    click_on 'Enviar pergunta'

    ###
    expect(page).to have_field 'question_content' # Campo para fazer perguntas
    expect(page).to have_content 'Pergunta enviada com sucesso'
    expect(page).to have_content 'Ronaldinho: Esse suporte serve no Samsung s10?'
  end

  it 'admin responde' do
    ###
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                           cpf: '30448522500')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')

    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_date_a = 1.day.from_now,
                        end_date: end_date_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
    lot_a.update(status: :approved, approver: admin_b)

    login_as user_a
    visit root_path
    click_on lot_a.code
    fill_in 'question_content',	with: 'Esse suporte serve no Samsung s10?' # Esse campo só aparece para usuário autenticado não-admin, conforme será mostrado em outros testes
    click_on 'Enviar pergunta'
    logout

    ### ACT
    login_as admin_x
    visit root_path
    click_on 'TAREFAS ADMIN'

    within('#unanswered_questions') do
      fill_in 'question_answer',	with: 'Olá, ele suporte qualquer aparelho até 300g.'
      click_on 'Enviar resposta'
    end

    ###
    expect(page).to have_content 'Pergunta atualizada com sucesso'
    expect(page).to have_content 'Resposta (Marcelinho) : Olá, ele suporte qualquer aparelho até 300g'
  end

  it 'visitante visualiza mas não faz perguntas' do
    ###
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                           cpf: '30448522500')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')

    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_date_a = 1.day.from_now,
                        end_date: end_date_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
    lot_a.update(status: :approved, approver: admin_b)

    login_as user_a
    visit root_path
    click_on lot_a.code
    fill_in 'question_content',	with: 'Esse suporte serve no Samsung s10?' # Esse campo só aparece para usuário autenticado não-admin, conforme será mostrado neste teste
    click_on 'Enviar pergunta'
    logout

    login_as admin_x
    visit root_path
    click_on 'TAREFAS ADMIN'

    within('#unanswered_questions') do
      fill_in 'question_answer',	with: 'Olá, ele suporte qualquer aparelho até 300g.'
      click_on 'Enviar resposta'
    end
    logout

    ### ACT
    visit root_path
    click_on lot_a.code

    ### ASSERT
    expect(page).not_to have_field 'question_content' # Não tem campo para visitante fazer perguntas
    expect(page).not_to have_content 'Faça uma pergunta sobre o lote'

    expect(page).to have_content lot_a.code
    expect(page).to have_content 'Suporte de Celular'
    expect(page).to have_content 'Perguntas e Respostas'
    expect(page).to have_content 'Ronaldinho: Esse suporte serve no Samsung s10?'
    expect(page).to have_content 'Resposta (Marcelinho) : Olá, ele suporte qualquer aparelho até 300g'
  end

  it 'autenticado visualiza' do
    ###
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                           cpf: '30448522500')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')

    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_date_a = 1.day.from_now,
                        end_date: end_date_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
    lot_a.update(status: :approved, approver: admin_b)

    login_as user_a
    visit root_path
    click_on lot_a.code
    fill_in 'question_content',	with: 'Esse suporte serve no Samsung s10?'
    click_on 'Enviar pergunta'
    logout

    login_as admin_x
    visit root_path
    click_on 'TAREFAS ADMIN'

    within('#unanswered_questions') do
      fill_in 'question_answer',	with: 'Olá, ele suporte qualquer aparelho até 300g.'
      click_on 'Enviar resposta'
    end
    logout

    ### ACT
    login_as user_b
    visit root_path
    click_on lot_a.code

    ###
    expect(page).to have_content lot_a.code
    expect(page).to have_content 'Suporte de Celular'
    expect(page).to have_content 'Perguntas e Respostas'
    expect(page).to have_content 'Ronaldinho: Esse suporte serve no Samsung s10?'
    expect(page).to have_content 'Resposta (Marcelinho) : Olá, ele suporte qualquer aparelho até 300g'
    expect(page).to have_content 'Faça uma pergunta sobre o lote'
  end

  it 'admin oculta e usuário não vê' do
    ###
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                           cpf: '30448522500')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')

    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_date_a = 1.day.from_now,
                        end_date: end_date_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
    lot_a.update(status: :approved, approver: admin_b)

    login_as user_a
    visit root_path
    click_on lot_a.code
    fill_in 'question_content',	with: 'Eu vendo mais barato! Cel: 41 9966-5544'
    click_on 'Enviar pergunta'
    logout

    login_as admin_x
    visit root_path
    click_on 'TAREFAS ADMIN'

    within('#unanswered_questions') do
      check 'question_hidden'
      click_on 'Enviar resposta'
    end
    logout

    ### ACT
    login_as user_a
    visit root_path
    click_on lot_a.code

    ###
    expect(page).to have_content lot_a.code
    expect(page).to have_content 'Suporte de Celular'
    expect(page).to have_content 'Perguntas e Respostas'
    expect(page).not_to have_content 'Eu vendo mais barato! Cel: 41 9966-5544'
    expect(page).to have_content 'Nenhuma pergunta'
  end
end
