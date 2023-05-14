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

describe "Usuário navega até lot#show" do
  context "e analise se os lances estão aberto ou não" do
    it "antes da execução do leilão" do
      # Criar lote com itens
      start_date = Time.now + 1.day
      end_date = Time.now + 3.days
      
      lot_a = create_approved_lot(start_date, end_date, minimum_bid = 200, minimum_bid_increment = 20) #Função personalizada
      
      # Navegar até a página ANTES do leilão
      visit '/'
      click_on lot_a.code
      
      # Verificação de informações de leilão NÃO DISPONÍVEL
      expect(page).not_to  have_content 'Leilão Aberto'
      expect(page).to  have_content 'Leilão Não disponível'
      
      expect(page).to  have_content 'Moto G'
      expect(page).to  have_content 'Suporte de Celular'
      expect(page).to  have_content 'Microondas'
    end

    it "durante a execução do leilão" do
      # Criar lote com itens
      start_date = Time.now + 1.day
      end_date = Time.now + 3.days
      
      lot_a = create_approved_lot(start_date, end_date, minimum_bid = 200, minimum_bid_increment = 20) #Função personalizada
      
      # Navegar até a página DURANTE a execução do leilão
      travel_to start_date + 1.day
      visit '/'
      click_on lot_a.code
      
      # Verificação de informações de leilão ABERTO
      expect(page).to  have_content 'Leilão Aberto'
      expect(page).not_to  have_content 'Leilão Não disponível'
      
      expect(page).to  have_content 'Moto G'
      expect(page).to  have_content 'Suporte de Celular'
      expect(page).to  have_content 'Microondas'
    end

    it "após a execução do leilão" do
      # Criar lote com itens
      start_date = Time.now + 1.day
      end_date = Time.now + 3.days
      
      lot_a = create_approved_lot(start_date, end_date, minimum_bid = 200, minimum_bid_increment = 20) #Função personalizada
      
      # Navegar até a página APÓS a execução do leilão
      travel_to end_date + 1.day
      visit '/'
      click_on lot_a.code
      
      # Verificação de informações de leilão NÃO DISPONÍVEL
      expect(page).not_to  have_content 'Leilão Aberto'
      expect(page).to  have_content 'Leilão Não disponível'
      
      expect(page).to  have_content 'Moto G'
      expect(page).to  have_content 'Suporte de Celular'
      expect(page).to  have_content 'Microondas'
    end
  
  end

  context "está autenticado" do
    it "e faz um lance" do
      
    end
    
    
  end
  

end
