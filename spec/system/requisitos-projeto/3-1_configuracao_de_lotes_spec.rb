# Um administrador autenticado pode criar um lote para leilão. Cada lote deve possuir um código único cadastrado manualmente e composto por 3 letras e 6 caracteres, uma data início e uma data limite para recebimento de lances, um valor mínimo do lance e a diferença mínima entre lances. 
# Testes:
# Criação de lotes
#   sucesso
#   erros


require 'rails_helper'

describe "Cadastro de lotes" do
  context "com sucesso" do
    it "com todos os campos ok" do
      #
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      
      #
      login_as admin_a
      visit root_path
      click_on 'Cadastrar Lotes'
      fill_in "Código",	with: "ABC123456" 
      fill_in "Lance mínimo",	with: "199.99" 
      fill_in "Incremento mínimo",	with: "10.00" 
      fill_in "Data de início",	with: start_date = 1.day.from_now
      fill_in "Data de término",	with: end_date = 3.days.from_now
      click_on 'Enviar'
      #
      expect(page).to have_content 'Lote cadastrado com sucesso'
      expect(page).to have_content 'Código: ABC123456'
      expect(page).to have_content "Data de Início: #{I18n.l(start_date, format: :long)}"
      expect(page).to have_content "Data de Término: #{I18n.l(end_date, format: :long)}"
      expect(page).to have_content 'Lance Mínimo: 199.99'
      expect(page).to have_content 'Incremento Mínimo: 10'
      expect(page).to have_content 'Status: Aguardando Aprovação'
      expect(page).to have_content 'Criador: Ronaldo'
      
      # expect(page).to have_content 'banana'
    end
  end

  context "com erros" do
    it "campos faltantes" do
      #
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
      
      #
      login_as admin_a
      visit root_path
      click_on 'Cadastrar Lotes'
      fill_in "Código",	with: "" 
      fill_in "Lance mínimo",	with: "" 
      fill_in "Incremento mínimo",	with: "" 
      fill_in "Data de início",	with: ""
      fill_in "Data de término",	with: ""
      click_on 'Enviar'
      #
      expect(page).to have_content 'Lote não cadastrado'
      expect(page).to have_content 'Verifique os erros abaixo:'
      expect(page).to have_content 'Código não pode ficar em branco'
      expect(page).to have_content 'Código Formato: 3 letras maiúsculas seguidas por 6 números (ex.: XYZ369258)'
      expect(page).to have_content 'Lance mínimo não pode ficar em branco'
      expect(page).to have_content 'Lance mínimo não é um número'
      expect(page).to have_content 'Incremento mínimo não pode ficar em branco'
      expect(page).to have_content 'Incremento mínimo não é um número'
      expect(page).to have_content 'Data de início não pode ficar em branco'
      expect(page).to have_content 'Data de término não pode ficar em branco'
      
      #expect(page).to have_content 'banana'
    end

    it "usuário sem permissão" do
      #
      user_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@timao.com.br', password: '123456', cpf: '69142235219')
      
      #
      login_as user_a
      visit root_path

      #
      within('nav') do
        expect(page).not_to have_link('Cadastrar Lotes')
      end
    end
    
    it "hacker sem permissão" do
      #
      user_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@timao.com.br', password: '123456', cpf: '69142235219')
  
      #
      login_as user_a
      visit root_path
      visit new_admin_lot_path

      #
      expect(page).to have_content 'Você não tem permissão para acessar esta área'
      expect(current_path).to eq(root_path)
  
      #expect(page).to have_content 'banana'
    end
    
  end
  
end
