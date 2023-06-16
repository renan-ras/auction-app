# Um usuário administrador autenticado deverá ser capaz de cadastrar itens para venda via leilão. Cada item deve conter um nome, uma descrição em texto, uma foto, peso, dimensões em cm (largura, altura e profundidade) e uma categoria de produto. Cada item é único, então, por mais que existam itens repetidos, o cadastro deverá ser feito de forma individual. Cada item cadastrado deverá possuir um código alfanumérico de 10 caracteres gerado automaticamente.

require 'rails_helper'

# cadastro com sucesso
# erro usuário comum
# erro campos faltantes

describe 'Cadastro de items' do
  context 'com sucesso' do
    it 'informando todos os campos' do
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')

      login_as admin_a
      visit root_path
      click_on 'Cadastrar Itens'
      fill_in 'Nome',	with: 'Item 01'
      fill_in 'Descrição',	with: 'Este item é muito bom!'
      fill_in 'Peso (g)',	with: '100'
      fill_in 'Largura (cm)',	with: '10'
      fill_in 'Altura (cm)',	with: '15'
      fill_in 'Profundidade (cm)',	with: '22'
      fill_in 'Categoria',	with: 'Acessórios'
      attach_file 'item[image]', Rails.root.join('spec/images/celular.jpeg')

      click_on 'Enviar'
      expect(page).to have_content 'Item cadastrado com sucesso'
      expect(page).to have_css("img[src*='celular.jpeg']")
      expect(page.body).to match(/Código: [A-Z0-9]{10}/)
      expect(page).to have_content 'Lote: Sem lote associado'
      expect(page).to have_content 'Categoria: Acessórios'
      expect(page).to have_content 'Profundidade: 22'
      expect(page).to have_content 'Altura: 15'
      expect(page).to have_content 'Largura: 10'
      expect(page).to have_content 'Peso: 100'
      expect(page).to have_content 'Descrição: Este item é muito bom!'
      expect(page).to have_content 'Nome: Item 01'

      # expect(page).to have_content 'banana'
    end

    it 'usando a imagem padrão' do
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')

      login_as admin_a
      visit root_path
      click_on 'Cadastrar Itens'
      fill_in 'Nome',	with: 'Item 01'
      fill_in 'Descrição',	with: 'Este item é muito bom!'
      fill_in 'Peso (g)',	with: '100'
      fill_in 'Largura (cm)',	with: '10'
      fill_in 'Altura (cm)',	with: '15'
      fill_in 'Profundidade (cm)',	with: '22'
      fill_in 'Categoria',	with: 'Acessórios'
      # attach_file 'item[image]', Rails.root.join('spec/images/celular.jpeg')
      # app/assets/images/imagem_padrao.jpg
      click_on 'Enviar'
      expect(page).to have_content 'Item cadastrado com sucesso'
      expect(page).to have_css("img[src*='imagem_padrao']")
      expect(page.body).to match(/Código: [A-Z0-9]{10}/)
      expect(page).to have_content 'Lote: Sem lote associado'
      expect(page).to have_content 'Categoria: Acessórios'
      expect(page).to have_content 'Profundidade: 22'
      expect(page).to have_content 'Altura: 15'
      expect(page).to have_content 'Largura: 10'
      expect(page).to have_content 'Peso: 100'
      expect(page).to have_content 'Descrição: Este item é muito bom!'
      expect(page).to have_content 'Nome: Item 01'

      # expect(page).to have_content 'banana'
    end
  end

  context 'com erro:' do
    it 'campos faltantes' do
      admin_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                             cpf: '69142235219')

      login_as admin_a
      visit root_path
      click_on 'Cadastrar Itens'
      fill_in 'Nome',	with: ''
      fill_in 'Descrição',	with: ''
      fill_in 'Peso (g)',	with: ''
      fill_in 'Largura (cm)',	with: ''
      fill_in 'Altura (cm)',	with: ''
      fill_in 'Profundidade (cm)',	with: ''
      fill_in 'Categoria',	with: ''

      click_on 'Enviar'
      expect(page).to have_content 'Item não cadastrado'
      expect(page).to have_content 'Nome não pode ficar em branco'
      expect(page).to have_content 'Descrição não pode ficar em branco'
      expect(page).to have_content 'Peso não pode ficar em branco'
      expect(page).to have_content 'Largura não pode ficar em branco'
      expect(page).to have_content 'Altura não pode ficar em branco'
      expect(page).to have_content 'Profundidade não pode ficar em branco'
      expect(page).to have_content 'Peso não é um número'
      expect(page).to have_content 'Largura não é um número'
      expect(page).to have_content 'Altura não é um número'
      expect(page).to have_content 'Profundidade não é um número'

      # expect(page).to have_content 'banana'
    end

    it 'usuário sem permissão' do
      user_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@timao.com.br', password: '123456', cpf: '69142235219')

      login_as user_a
      visit root_path

      within('nav') do
        expect(page).not_to have_link('Cadastrar Itens')
      end

      # expect(page).to have_content 'banana'
    end

    it 'hacker sem permissão' do
      user_a = User.create!(nickname: 'Ronaldo', email: 'fenomeno@timao.com.br', password: '123456', cpf: '69142235219')

      login_as user_a
      visit root_path
      visit new_admin_item_path

      expect(page).to have_content 'Você não tem permissão para acessar esta área'
      expect(current_path).to eq(root_path)

      # expect(page).to have_content 'banana'
    end
  end
end
