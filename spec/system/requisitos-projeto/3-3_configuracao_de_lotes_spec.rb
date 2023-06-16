# Um lote deve ser aprovado antes de ser disponibilizado para os usuários visualizarem.
## Testes
## Usuário vizualiza lote aprovado
## Usuário não vizualiza lote aguardando aprovação

# A aprovação deve ser feita por um usuário diferente do usuário que cadastrou o lote e precisa ser registrado no sistema quem foram os usuários responsáveis tanto pelo cadastro quanto pela aprovação.
## sucesso na aprovação mostrando os responsáveis
## erro na aprovação

require 'rails_helper'

context 'Usuário comum' do
  it 'não vê Lote Aguardando Aprovação' do
    # Cria lote com itens
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')
    lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100,
                        minimum_bid_increment: 10, creator: admin_a)
    item_a.update(lot_id: lot_a.id)
    item_b.update(lot_id: lot_a.id)
    item_c.update(lot_id: lot_a.id)
    login_as user_a
    visit root_path

    expect(page).not_to have_link lot_a.code
  end

  it 'vê Lote Aprovado' do
    # Cria lote aprovado com itens
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')
    lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100,
                        minimum_bid_increment: 10, creator: admin_a)
    item_a.update(lot_id: lot_a.id)
    item_b.update(lot_id: lot_a.id)
    item_c.update(lot_id: lot_a.id)
    lot_a.update(status: :approved, approver: admin_b)
    login_as user_a
    visit root_path

    expect(page).to have_link lot_a.code
  end
end

context 'Admin' do
  ## sucesso na aprovação mostrando os responsáveis
  it 'aprova lote de outro criador' do
    # Cria lote com itens
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')
    lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100,
                        minimum_bid_increment: 10, creator: admin_a)
    item_a.update(lot_id: lot_a.id)
    item_b.update(lot_id: lot_a.id)
    item_c.update(lot_id: lot_a.id)
    login_as admin_b
    visit lot_path(lot_a)
    click_on 'Aprovar'
    expect(page).to have_content 'Lote aprovado com sucesso'
    expect(page).to have_content 'Status: Aprovado'
    expect(page).to have_content 'Criador: Ronaldo'
    expect(page).to have_content 'Aprovador: Pele'
  end

  it 'não aprova sua própria criação' do
    # Cria lote com itens
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')
    lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100,
                        minimum_bid_increment: 10, creator: admin_a)
    item_a.update(lot_id: lot_a.id)
    item_b.update(lot_id: lot_a.id)
    item_c.update(lot_id: lot_a.id)
    #
    login_as admin_a # = ao Criador
    visit lot_path(lot_a)
    click_on 'Aprovar'
    expect(page).to have_content 'Erro ao aprovar lote: Você não pode aprovar um lote que criou'
    expect(page).to have_content 'Status: Aguardando Aprovação'
    expect(page).to have_content 'Criador: Ronaldo'
  end
end
