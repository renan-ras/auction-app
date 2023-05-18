#Usuário autenticado pode salvar lotes nos quais tem interesse em visitar depois. Usuários autenticados podem adicionar ou remover lotes da lista de favoritos. Lotes que perderam a validade devem ser indicados.

require 'rails_helper'

context "usuário comum" do
  it "adiciona lote aos favoritos" do
    ### Cria lote aprovado
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456', cpf: '30448522500')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')

    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now, end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
    item_a.update(lot_id: lot_a.id)
    item_b.update(lot_id: lot_a.id)
    item_c.update(lot_id: lot_a.id)
    lot_a.update(status: :approved, approver: admin_b)
    
    ###
    login_as user_a
    visit root_path
    click_on lot_a.code
    click_on 'Adicionar aos Favoritos'
    click_on 'PAINEL DO USUÁRIO'

    ### ASSERT
    within("#favorite_lots") do #Lista de lotes favoritos
      expect(page).to have_link lot_a.code
      click_on lot_a.code
    end
    expect(page).to have_button 'Remover dos Favoritos'
  end

  it "remove dos favoritos" do
    ### Cria lote aprovado
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456', cpf: '30448522500')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')

    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now, end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
    item_a.update(lot_id: lot_a.id)
    item_b.update(lot_id: lot_a.id)
    item_c.update(lot_id: lot_a.id)
    lot_a.update(status: :approved, approver: admin_b)
    
    login_as user_a
    visit root_path
    click_on lot_a.code
    click_on 'Adicionar aos Favoritos'
    logout
    
    ### ACT
    login_as user_a
    visit root_path
    click_on 'PAINEL DO USUÁRIO'
    within("#favorite_lots") do #Lista de lotes favoritos
      click_on lot_a.code
    end
    click_on 'Remover dos Favoritos'

    ### ASSERT
    expect(page).to have_button 'Adicionar aos Favoritos'
    click_on 'PAINEL DO USUÁRIO'
    within("#favorite_lots") do #Lista de lotes favoritos
      expect(page).not_to have_link lot_a.code
    end
  end
  
  it "e verifica a validade dos lotes" do
    ### Cria lote aprovado
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456', cpf: '30448522500')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')

    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now, end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
    item_a.update(lot_id: lot_a.id)
    item_b.update(lot_id: lot_a.id)
    item_c.update(lot_id: lot_a.id)
    lot_a.update(status: :approved, approver: admin_b)
    
    login_as user_a
    visit root_path
    click_on lot_a.code
    click_on 'Adicionar aos Favoritos'
    logout

    travel_to end_lot_a + 1.hour # Após o término do lote
    
    ### ACT
    login_as user_a
    visit root_path
    click_on 'PAINEL DO USUÁRIO'

    
    ### ASSERT
    within("#favorite_lots") do #Lista de lotes favoritos
      expect(page).to have_link lot_a.code
      expect(page).to have_content 'Encerrado'
      expect(page).not_to have_content 'Não Iniciado'
      expect(page).not_to have_content 'Em Andamento'
    end

    
  end

end

context "visitante" do
  it "NÃO adiciona lote aos favoritos" do
    ### Cria lote aprovado
    user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
    user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
    admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
    admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456', cpf: '30448522500')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')

    lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now, end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
    item_a.update(lot_id: lot_a.id)
    item_b.update(lot_id: lot_a.id)
    item_c.update(lot_id: lot_a.id)
    lot_a.update(status: :approved, approver: admin_b)
    
    ###
    visit root_path
    click_on lot_a.code

    ### ASSERT
    expect(page).not_to have_button 'Adicionar aos Favoritos'
  end
  
end

