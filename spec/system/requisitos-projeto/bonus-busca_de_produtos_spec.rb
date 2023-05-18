#Na tela de listagem de lotes, um usuário visitante ou autenticado pode fazer uma busca informando um texto. Esta busca deve considerar o texto informado e buscar por código de lote e nome de produtos incluídos em um lote. O resultado deve listar lotes onde foi encontrado o texto informado.
#buscar item
#buscar lote

require 'rails_helper'

context "Visitante realiza busca" do
  it "por itens" do
    ###
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
    
    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_date_a = 1.day.from_now, end_date: end_date_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
    lot_a.update(status: :approved, approver: admin_b)
  
    lot_b = Lot.create!(code: 'ABC987654', start_date: start_date_b = 1.hour.from_now, end_date: end_date_b = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_c.update(lot_id: lot_b.id) # Item C adicionado ao Lote B
    item_a.update(lot_id: lot_b.id) # Item A adicionado ao Lote B
    lot_b.update(status: :approved, approver: admin_b)

    ###
    visit root_path
    fill_in "search",	with: "Celular" 
    click_on 'Buscar'
    
    ###
    expect(page).to have_link 'XYZ123456'
    expect(page).not_to have_link 'ABC987654'
  end

  it "por código" do
    ###
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
    
    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_date_a = 1.day.from_now, end_date: end_date_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
    lot_a.update(status: :approved, approver: admin_b)
  
    lot_b = Lot.create!(code: 'ABC987654', start_date: start_date_b = 1.hour.from_now, end_date: end_date_b = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_c.update(lot_id: lot_b.id) # Item C adicionado ao Lote B
    item_a.update(lot_id: lot_b.id) # Item A adicionado ao Lote B
    lot_b.update(status: :approved, approver: admin_b)

    ###
    visit root_path
    fill_in "search",	with: "BC98" 
    click_on 'Buscar'
    
    ###
    expect(page).not_to have_link 'XYZ123456'
    expect(page).to have_link 'ABC987654'
  end
  
end
