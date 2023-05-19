require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Registro de usuário' do
    context "comum" do
      it "com sucesso" do
        #
        user_a = User.new(nickname: 'Ronaldo', email: 'fenomeno@timao.com', password: '123456', cpf: '69142235219')
        #
        result = user_a.valid?
        # Assert
        expect(result).to eq true
        expect(user_a.admin?).to eq false
      end
    end

    context "admin" do
      it "com sucesso" do
        #
        user_a = User.new(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456', cpf: '69142235219')
        #
        result = user_a.valid?
        # Assert
        expect(result).to eq true
        expect(user_a.admin?).to eq true
      end
    end
  end
  
end
