require 'rails_helper'

# VALIDANDO RESULTADOS

# leilão encerrado
# #com lances / sem lances
# ##admin confere resultado
# ##admin valida resultado
# ##user confere resultado

describe 'Leilão encerrado' do
  context 'com lances' do
    it 'admin confere resultado' do
      ###
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456',
                            cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456',
                            cpf: '94462646690')
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456',
                             cpf: '15703243017')
      admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                             cpf: '30448522500')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                            depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                            height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                            depth: '30', category: 'Eletrodomésticos')

      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now,
                          end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)

      travel_to start_lot_a + 1.hour
      # lot_a "Em Andamento"
      bid_a = Bid.create!(amount: minimum_bid, user: user_a, lot: lot_a)
      bid_b = Bid.create!(amount: minimum_bid + minimum_bid_increment, user: user_b, lot: lot_a)
      bid_c = Bid.create!(amount: minimum_bid + (minimum_bid_increment * 2), user: user_a, lot: lot_a)
      travel_to end_lot_a + 1.hour
      # lot_a "Encerrado"

      ### ACT
      login_as admin_x
      visit root_path
      click_on 'TAREFAS ADMIN'
      click_on lot_a.code

      ###
      expect(page).to have_content 'Leilão Encerrado'
      expect(page).to have_content 'Validar Resultado do Leilão'
      expect(page).to have_content 'Lance Atual: R$ 104,00 pelo usuário: Ronaldinho'
      expect(page).to have_button 'Vender Lote'
    end

    it 'admin valida resultado' do
      ###
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456',
                            cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456',
                            cpf: '94462646690')
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456',
                             cpf: '15703243017')
      admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                             cpf: '30448522500')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                            depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                            height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                            depth: '30', category: 'Eletrodomésticos')

      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now,
                          end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)

      travel_to start_lot_a + 1.hour
      # lot_a "Em Andamento"
      bid_a = Bid.create!(amount: minimum_bid, user: user_a, lot: lot_a)
      bid_b = Bid.create!(amount: minimum_bid + minimum_bid_increment, user: user_b, lot: lot_a)
      bid_c = Bid.create!(amount: minimum_bid + (minimum_bid_increment * 2), user: user_a, lot: lot_a)
      travel_to end_lot_a + 1.hour
      # lot_a "Encerrado"

      ### ACT
      login_as admin_x
      visit lot_path(lot_a)
      click_on 'Vender Lote'

      ###
      expect(page).not_to have_content 'Validar Resultado do Leilão'
      expect(page).not_to have_button 'Vender Lote'
      expect(page).to have_content 'Leilão Encerrado'
      expect(page).to have_content 'Lote vendido com sucesso'
      expect(page).to have_content 'Status: Vendido'
    end

    it 'vencedor confere o resultado' do
      ###
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456',
                            cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456',
                            cpf: '94462646690')
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456',
                             cpf: '15703243017')
      admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                             cpf: '30448522500')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                            depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                            height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                            depth: '30', category: 'Eletrodomésticos')

      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now,
                          end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)

      travel_to start_lot_a + 1.hour
      # lot_a "Em Andamento"
      bid_a = Bid.create!(amount: minimum_bid, user: user_a, lot: lot_a)
      bid_b = Bid.create!(amount: minimum_bid + minimum_bid_increment, user: user_b, lot: lot_a)
      bid_c = Bid.create!(amount: minimum_bid + (minimum_bid_increment * 2), user: user_a, lot: lot_a)
      travel_to end_lot_a + 1.hour
      # lot_a "Encerrado"
      login_as admin_x
      visit lot_path(lot_a)
      click_on 'Vender Lote'
      logout

      ### ACT
      login_as user_a
      visit root_path
      click_on 'PAINEL DO USUÁRIO'

      within('#won_lots') do # Lista de lotes arrematados
        click_on lot_a.code
      end

      ###
      expect(page).to have_content 'Leilão Encerrado'
      expect(page).to have_content 'Lance Atual: R$ 104,00 pelo usuário: Ronaldinho'
    end

    it 'perdedor confere o resultado' do
      ###
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456',
                            cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456',
                            cpf: '94462646690')
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456',
                             cpf: '15703243017')
      admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                             cpf: '30448522500')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                            depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                            height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                            depth: '30', category: 'Eletrodomésticos')

      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now,
                          end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)

      travel_to start_lot_a + 1.hour
      # lot_a "Em Andamento"
      bid_a = Bid.create!(amount: minimum_bid, user: user_a, lot: lot_a)
      bid_b = Bid.create!(amount: minimum_bid + minimum_bid_increment, user: user_b, lot: lot_a)
      bid_c = Bid.create!(amount: minimum_bid + (minimum_bid_increment * 2), user: user_a, lot: lot_a)
      travel_to end_lot_a + 1.hour
      # lot_a "Encerrado"
      login_as admin_x
      visit lot_path(lot_a)
      click_on 'Vender Lote'
      logout

      ### ACT
      login_as user_b
      visit root_path
      click_on 'PAINEL DO USUÁRIO'

      within('#bided_lots') do # Lista de leilões participados
        click_on lot_a.code
      end

      ###
      expect(page).to have_content 'Leilão Encerrado'
      expect(page).to have_content 'Lance Atual: R$ 104,00 pelo usuário: Ronaldinho'
    end
  end

  context 'sem lances' do
    it 'admin confere resultado' do
      ###
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456',
                            cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456',
                            cpf: '94462646690')
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456',
                             cpf: '15703243017')
      admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                             cpf: '30448522500')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                            depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                            height: '10', depth: '5', category: 'Acessórios')
      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                            depth: '30', category: 'Eletrodomésticos')

      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now,
                          end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      item_c.update(lot_id: lot_a.id)
      lot_a.update(status: :approved, approver: admin_b)

      travel_to start_lot_a + 1.hour # lot_a "Em Andamento"
      # Nenhum lance
      travel_to end_lot_a + 1.hour # lot_a "Encerrado"

      ### ACT
      login_as admin_x
      visit root_path
      click_on 'TAREFAS ADMIN'
      click_on lot_a.code

      ###
      expect(page).to have_content 'Leilão Encerrado'
      expect(page).to have_content 'Validar Resultado do Leilão'
      expect(page).to have_content 'Nenhum lance registrado'
      expect(page).to have_button 'Cancelar Lote'
    end

    it 'admin valida resultado e itens voltam a ficar disponíveis' do
      ###
      user_a = User.create!(nickname: 'Ronaldinho', email: 'gaucho@email.com.br', password: '123456',
                            cpf: '74481225840')
      user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456',
                            cpf: '94462646690')
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')
      admin_b = User.create!(nickname: 'Pele', email: 'rei@leilaodogalpao.com.br', password: '123456',
                             cpf: '15703243017')
      admin_x = User.create!(nickname: 'Marcelinho', email: 'carioca@leilaodogalpao.com.br', password: '123456',
                             cpf: '30448522500')
      item_a = Item.create!(name: 'Moto G', description: '16GB RAM 512GB HD', weight: '200', width: '5', height: '16',
                            depth: '2', category: 'Eletrônicos')
      item_b = Item.create!(name: 'Suporte de Celular', description: 'material plástico ABS', weight: '50', width: '6',
                            height: '10', depth: '5', category: 'Acessórios')

      item_c = Item.create!(name: 'Microondas', description: '600W 10L', weight: '10000', width: '40', height: '25',
                            depth: '30', category: 'Eletrodomésticos')

      lot_a = Lot.create!(code: 'XYZ123456', start_date: start_lot_a = 1.hour.from_now,
                          end_date: end_lot_a = 3.days.from_now, minimum_bid: minimum_bid = 100, minimum_bid_increment: minimum_bid_increment = 2, creator: admin_a)
      item_a.update(lot_id: lot_a.id)
      item_b.update(lot_id: lot_a.id)
      # item_c NÂO adicionado ao lot_a
      lot_a.update(status: :approved, approver: admin_b)

      travel_to start_lot_a + 1.hour # lot_a "Em Andamento"
      # Nenhum lance
      travel_to end_lot_a + 1.hour # lot_a "Encerrado"

      ### ACT
      login_as admin_x
      # Verificando itens disponíveis ANTES do cancelamento do lote
      lot_b = Lot.create!(code: 'ABC123456', start_date: start_b = 1.hour.from_now, end_date: 3.days.from_now,
                          minimum_bid: 100, minimum_bid_increment: 10, creator: admin_a)
      visit lot_path(lot_b)
      ### ASSERT PART1
      expect(page).to have_content "#{item_c.code} - Microondas"
      expect(page).not_to have_content "#{item_b.code} - Suporte de Celular"
      expect(page).not_to have_content "#{item_a.code} - Moto G"
      ### END
      visit lot_path(lot_a)
      click_on 'Cancelar Lote'
      expect(page).to have_content 'Status: Cancelado'
      # Verificando itens disponíveis APÓS do cancelamento do lote
      visit lot_path(lot_b)

      ### ASSERT PART2
      expect(page).to have_content "#{item_c.code} - Microondas"
      expect(page).to have_content "#{item_b.code} - Suporte de Celular"
      expect(page).to have_content "#{item_a.code} - Moto G"
    end
  end
end
