require "rails_helper"

describe 'Usuário vê tela inicial' do
    it 'e vê o título da página' do
        # Arrange
        
        # Act
        visit('/')

        # Assert
        expect(page).to have_content('Sistema de Leilões')
    end
end