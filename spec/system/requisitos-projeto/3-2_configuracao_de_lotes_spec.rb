# Depois deste cadastro inicial deve ser possível adicionar e remover itens para leilão no lote. Os itens podem ser adicionados e removidos do lote enquanto ele estiver no status "aguardando aprovação", que é o status determinado automaticamente durante o cadastro de um lote.
# Testes:
# status = "aguardando aprovação"
#   Adição de itens
#   Remoção de itens
# status != "aguardando aprovação"
#   Adição de itens
#   Remoção de itens

require 'rails_helper'

context 'Lote Aguardando Aprovação' do
  it 'Adiciona itens' do
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')
    lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100,
                        minimum_bid_increment: 10, creator: admin_a)
    login_as admin_a
    visit root_path
    click_on 'LOTES PRIVADOS'
    click_on lot_a.code
    select "#{item_b.code} - #{item_b.name}", from: 'item_id'
    click_on 'Adicionar'
    select "#{item_c.code} - #{item_c.name}", from: 'item_id'
    click_on 'Adicionar'

    expect(page).to have_content 'Item adicionado ao lote com sucesso'
    expect(page).to have_content 'Nome: Suporte de Celular'
    expect(page).to have_content 'Nome: Microondas'
    expect(page).not_to have_content 'Nome: Moto G'

    # expect(page).to have_content 'banana'
  end

  it 'Remove itens' do
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                          depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                          height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                          depth: '30', category: 'Eletrodomésticos')
    lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100,
                        minimum_bid_increment: 10, creator: admin_a)
    ## Adiciona itens ao lote
    item_a.update(lot_id: lot_a.id)
    item_b.update(lot_id: lot_a.id)
    item_c.update(lot_id: lot_a.id)
    login_as admin_a
    visit root_path
    click_on 'LOTES PRIVADOS'
    click_on lot_a.code

    within("#item-#{item_b.id}") do
      click_on 'Remover do lote'
    end

    expect(page).to have_content 'Item removido do lote com sucesso'
    expect(page).not_to have_content 'Nome: Suporte de Celular'
    expect(page).to have_content 'Nome: Microondas'
    expect(page).to have_content 'Nome: Moto G'

    ## Tira-teima - Removendo mais um item
    within("#item-#{item_c.id}") do
      click_on 'Remover do lote'
    end
    expect(page).to have_content 'Item removido do lote com sucesso'
    expect(page).not_to have_content 'Nome: Suporte de Celular'
    expect(page).not_to have_content 'Nome: Microondas'
    expect(page).to have_content 'Nome: Moto G'
  end
end

context 'Lote Aprovado não' do
  it 'Adiciona ou Remove itens' do
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                           cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
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
    lot_a.update(status: :approved, approver: admin_b)

    login_as admin_a
    visit lot_path(lot_a)

    expect(page).not_to have_link('Adicionar')
    expect(page).not_to have_link('Remover do lote')
  end
end
