#Visitantes não autenticados e usuários regulares autenticados (os não administradores) devem ser capazes de navegar pela tela inicial da aplicação e visualizar os lotes para leilão. Devem ser exibidos de forma separada, mas na mesma página, os lotes em andamento e os lotes futuros. Ao acessar um lote, os usuários devem ser capazes de ver informações como: data início, data fim, lance mínimo e detalhes de todos os itens daquele lote.
## Criar lotes aprovados em andamento e futuro
## user/visitor views lots
##    "   "     views lots#items & datails

require 'rails_helper'

describe "Lotes (em andamento e) futuros" do
  
  context "por visitante" do
    
    it "são vistos na tela inicial" do
      # Criação de lotes em andamento e futuros
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
      
      lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
      lot_a.update(status: :approved, approver: admin_b)
    
      lot_b = Lot.create!(code: 'ABC123456', start_date: start_b = 1.hour.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_c.update(lot_id: lot_b.id) # Item C adicionado ao Lote B
      lot_b.update(status: :approved, approver: admin_b)
    
      travel_to start_b + 1.hour # lot_b "Em Andamento"
      
      #
      visit root_path
      #
      expect(page).to have_content 'Leilões em andamento'
      within("#open_auctions_lots") do
        expect(page).to have_link lot_b.code
      end
      
      expect(page).to have_content 'Leilões Futuros'
      within("#future_auctions_lots") do
        expect(page).to have_link lot_a.code
      end

    end

    it "e em detalhes" do
      # Criação de lotes em andamento e futuros
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
      
      lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
      lot_a.update(status: :approved, approver: admin_b)
    
      lot_b = Lot.create!(code: 'ABC123456', start_date: start_date_b = 1.hour.from_now, end_date: end_date_b = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_c.update(lot_id: lot_b.id) # Item C adicionado ao Lote B
      item_a.update(lot_id: lot_b.id) # Item A adicionado ao Lote B
      lot_b.update(status: :approved, approver: admin_b)
    
      travel_to start_date_b + 1.hour # lot_b "Em Andamento"
      
      #
      visit root_path
      click_on lot_b.code
      #
      expect(page).to have_content "Data de Início: #{I18n.l(start_date_b, format: :long)}"
      expect(page).to have_content "Data de Término: #{I18n.l(end_date_b, format: :long)}"
      expect(page).to have_content 'Lance Mínimo: 100'
      
      expect(page).to have_content 'Nome: Microondas'
      expect(page).to have_content 'Descrição: 600W 10L'
      expect(page).to have_content 'Peso: 10000 g'
      expect(page).to have_content 'Dimensões (cm): 25(A) x 40(L) x 30(P)'

      expect(page).to have_content 'Nome: Moto G'
      expect(page).to have_content 'Descrição: 16GB RAM 512GB HD'
      expect(page).to have_content 'Peso: 200 g'
      expect(page).to have_content 'Dimensões (cm): 16(A) x 5(L) x 2(P)'
    end

  end

  context "por usuário comum" do
    
    it "são vistos na tela inicial" do
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
      
      lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
      lot_a.update(status: :approved, approver: admin_b)
    
      lot_b = Lot.create!(code: 'ABC123456', start_date: start_b = 1.hour.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_c.update(lot_id: lot_b.id) # Item C adicionado ao Lote B
      lot_b.update(status: :approved, approver: admin_b)
    
      travel_to start_b + 1.hour # lot_b "Em Andamento"
      #
      login_as user_a
      visit root_path
      #
      expect(page).to have_content 'Leilões em andamento'
      within("#open_auctions_lots") do
        expect(page).to have_link lot_b.code
      end
      
      expect(page).to have_content 'Leilões Futuros'
      within("#future_auctions_lots") do
        expect(page).to have_link lot_a.code
      end

    end

    it "e em detalhes" do
      # Criação de lotes em andamento e futuros
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
      
      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_date_a = 1.day.from_now, end_date: end_date_a = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
      lot_a.update(status: :approved, approver: admin_b)
    
      lot_b = Lot.create!(code: 'ABC123456', start_date: start_date_b = 1.hour.from_now, end_date: end_date_b = 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      item_c.update(lot_id: lot_b.id) # Item C adicionado ao Lote B
      item_a.update(lot_id: lot_b.id) # Item A adicionado ao Lote B
      lot_b.update(status: :approved, approver: admin_b)
    
      travel_to start_date_b + 1.hour # lot_b "Em Andamento"
      
      #
      login_as user_a
      visit root_path
      click_on lot_a.code
      #
      expect(page).to have_content "Data de Início: #{I18n.l(start_date_a, format: :long)}"
      expect(page).to have_content "Data de Término: #{I18n.l(end_date_a, format: :long)}"
      expect(page).to have_content 'Lance Mínimo: 100'
      expect(page).to have_content 'Nome: Suporte de Celular'
      expect(page).to have_content 'Descrição: material plástico ABS'
      expect(page).to have_content 'Peso: 50 g'
      expect(page).to have_content 'Dimensões (cm): 10(A) x 6(L) x 5(P)'
    end

  end

end
