require 'rails_helper'

def create_approved_lot(start_date, end_date, minimum_bid, minimum_bid_increment)
  admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
  admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
  
  item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
  item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
  item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
  
  lot_a = Lot.create!(code: 'XYZ123456', start_date: start_date, end_date: end_date, minimum_bid: minimum_bid, minimum_bid_increment: minimum_bid_increment, creator: admin_a)

  # Adicionar itens ao lote
  item_a.update(lot_id: lot_a.id)
  item_b.update(lot_id: lot_a.id)
  item_c.update(lot_id: lot_a.id)

  lot_a.update(status: :approved, approver: admin_b)

  lot_a
end

describe "describe alg coisa" do
  context "context alg coisa" do
    it "Lote cancelado" do
      # Arrange
        # Criar lote aprovado
      start_date = Time.now + 1.day
      end_date = Time.now + 3.days
      lot_a = create_approved_lot(start_date, end_date, minimum_bid = 200, minimum_bid_increment = 20) #Função personalizada
      admin_x = lot_a.creator

      # Act
      login_as(admin_x)
      travel_to end_date + 1.day
      visit admin_dashboard_path
      click_on lot_a.code
      click_on 'Cancelar Lote'
      
      # Assert
      expect(page).to have_content 'Status: canceled'
    end
  end
end

describe "2describe alg coisa" do
  context "2context alg coisa" do
    it "Lote vendido" do
      # Arrange
        # Criar lote aprovado
      lot_a = create_approved_lot(start_date = Time.now + 1.day, end_date = Time.now + 3.days, minimum_bid = 200, minimum_bid_increment = 20) #Função personalizada
      admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456', cpf: '30448522500')
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456', cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456', cpf: '94462646690')

        # Fazer lance user_a
      login_as(user_a)
      travel_to start_date + 1.day
      visit root_path
      click_on lot_a.code
      fill_in "Próximo Lance",	with: minimum_bid
      click_on 'Fazer Lance'
      logout

        # Fazer lance user_b
      login_as(user_b)
      visit root_path
      click_on lot_a.code
      fill_in "Próximo Lance",	with: minimum_bid + minimum_bid_increment
      click_on 'Fazer Lance'
      logout
  
        # Admin valida o resultado
      login_as(admin_x)
      travel_to end_date + 1.day
      visit root_path
      click_on 'DASHBOARD'
      click_on lot_a.code
      click_on 'Vender Lote'
      # logout

      #Act. Usuário vencedor confere o resultado em seu dashboard
      # login_as(user_b)
      # visit root_path
      # click_on 'DASHBOARD'
      # click_on lot_a.code
      
      # Assert
      # expect(page).to have_content lot_a.code
      # expect(page).to have_content 'R$ 220,00'

      expect(page).to have_content 'TESTE_VISUALIZAR_PÁGINA'
    end
  end
end