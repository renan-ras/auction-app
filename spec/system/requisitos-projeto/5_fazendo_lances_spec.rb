require 'rails_helper'


describe "Usuário" do

  context "visitante" do
    it "não consegue fazer lance" do
      # Criação de lotes em andamento
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
    
      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now, end_date: end_lot_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)
    
      travel_to start_lot_a + 1.hour # lot_b "Em Andamento"
      
      # Fazer 1º Lance
      visit root_path
      click_on lot_a.code
    
      #
      expect(page).not_to have_field 'Próximo Lance'
      expect(page).to have_content 'Leilão Em Andamento'
    end
  end
  

  context "Autenticado" do
    it "faz Lance com sucesso" do
      # Criação de lotes em andamento
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
      
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
  
      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now, end_date: end_lot_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)
  
      travel_to start_lot_a + 1.hour # lot_b "Em Andamento"
      
      # Fazer 1º Lance
      login_as user_a
      visit root_path
      click_on lot_a.code
      fill_in "Próximo Lance",	with: '101'
      click_on 'Fazer Lance'
  
      #
      expect(page).to have_content 'Lance enviado com sucesso!'
      expect(page).to have_content 'Lance Atual: R$ 101,00 pelo usuário: Ronaldinho'
     
    end
  
    it "não faz Lance com incremento errado" do
      ### Criação de lotes em andamento
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')
      
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
  
      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now, end_date: end_lot_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)
  
      travel_to start_lot_a + 1.hour # lot_a "Em Andamento"
      
      ###
      # Fazer 1º Lance
      login_as user_a
      visit root_path
      click_on lot_a.code
      fill_in "Próximo Lance",	with: '101'
      click_on 'Fazer Lance'
      logout
      
      # Fazer 2º Lance
      login_as user_b
      visit root_path
      click_on lot_a.code
      fill_in "Próximo Lance",	with: '102'
      click_on 'Fazer Lance'
  
      ###
      expect(page).not_to have_content 'Lance enviado com sucesso!'
      expect(page).to have_content 'Não foi possível enviar o lance'
      expect(page).to have_content 'O lance deve ser maior ou igual ao maior lance + incremento mínimo'
      expect(page).to have_content 'Lance Atual: R$ 101,00 pelo usuário: Ronaldinho'
  
    end
  
    it "faz Lance com incremento correto" do
      ### Criação de lotes em andamento
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')
      
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
  
      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now, end_date: end_lot_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)
  
      travel_to start_lot_a + 1.hour # lot_a "Em Andamento"
      
      ###
      # Fazer 1º Lance
      login_as user_a
      visit root_path
      click_on lot_a.code
      fill_in "Próximo Lance",	with: '101'
      click_on 'Fazer Lance'
      logout
      
      # Fazer 2º Lance
      login_as user_b
      visit root_path
      click_on lot_a.code
      fill_in "Próximo Lance",	with: '103'
      click_on 'Fazer Lance'
  
      ###
      expect(page).to have_content 'Lance enviado com sucesso!'
      expect(page).not_to have_content 'Não foi possível enviar o lance'
      expect(page).not_to have_content 'O lance deve ser maior ou igual ao maior lance + incremento mínimo'
      expect(page).to have_content 'Lance Atual: R$ 103,00 pelo usuário: Richarlison'
    end
  
    it "não faz Lance fora do prazo" do
      ### Criação de lotes em andamento
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')
      
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
  
      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now, end_date: end_lot_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)
  
      travel_to start_lot_a + 1.hour # lot_a "Em Andamento"
      
      ###
      # Fazer 1º Lance
      login_as user_a
      visit root_path
      click_on lot_a.code
      fill_in "Próximo Lance",	with: '101'
      click_on 'Fazer Lance'
      logout
      
      # Fazer 2º Lance
      login_as user_b
      visit root_path
      click_on lot_a.code
      fill_in "Próximo Lance",	with: '103'
      click_on 'Fazer Lance'
      logout
  
      travel_to end_lot_a + 1.hour # lot_a "Encerrado"
      # Tenta Fazer 3º Lance fora do prazo
      login_as user_a
      visit root_path
  
      ###
      expect(page).not_to have_link lot_a.code
    end
    
  end
  
end

