require "rails_helper"

describe "Usuário navega até lot#show" do
  context "como visitante" do
    it "e vê itens associados ao lote" do
      #Arrange
      # Cadastrar tudo: users, items, lots; add items to lots;
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456', cpf: '15703243017')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
      
      lot_a = Lot.create!(code: 'XYZ123456', start_date: Time.now + 1.day, end_date: Time.now + 7.days, minimum_bid: 100.0, minimum_bid_increment: 10.0, creator: admin_a)

      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)

      lot_a.update(status: :approved, approver: admin_b)

      #Act
      visit '/'
      click_on 'XYZ123456'
      #Assert
      expect(page).to  have_content 'Moto G'
      expect(page).to  have_content 'Suporte de Celular'
      expect(page).not_to  have_content 'Microondas'

    end
  end

end
