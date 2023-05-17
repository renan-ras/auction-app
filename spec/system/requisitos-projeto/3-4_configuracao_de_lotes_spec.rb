#O mesmo item não pode estar presente em dois lotes diferentes.

require 'rails_helper'

context "O mesmo item" do
  
  it "em dois lotes" do
    # Cria lote com o item B
    admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
    item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16', depth: '2', category: 'Eletrônicos')
    item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6', height: '10', depth: '5', category: 'Acessórios')
    item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25', depth: '30', category: 'Eletrodomésticos')
    lot_a = Lot.create!(code: 'XYZ123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
    item_b.update(lot_id: lot_a.id) # Item B adicionado ao Lote A
    lot_b = Lot.create!(code: 'ABC123456', start_date: 1.day.from_now, end_date: 3.days.from_now, minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)

    #
    login_as admin_a
    visit lot_path(lot_b)

    # Item B indisponível para adição a outro lote
    expect(page).to have_content 'Status: Aguardando Aprovação'
    expect(page).not_to have_content "#{item_b.code} - #{item_b.name}"
    expect(page).to have_content "#{item_a.code} - #{item_a.name}"
    expect(page).to have_content "#{item_c.code} - #{item_c.name}"

  end

end