require 'rails_helper'

RSpec.describe BlockedCpf, type: :model do
  let(:valid_attributes) do
    {
      cpf: '80893978329',
      reason: 'Comportamento inadequado',
      blocked_by: User.create!(
        nickname: 'Ronaldo',
        email: 'fenomeno@leilaodogalpao.com.br',
        password: '123456',
        cpf: '69142235219'
      )
    }
  end

  describe 'validations' do
    context 'blocked_by must be admin' do
      it 'valid' do
        blocked_cpf = BlockedCpf.new(valid_attributes)

        expect(blocked_cpf.blocked_by.admin?).to be true
        expect(blocked_cpf).to be_valid
      end

      it 'invalid' do
        user = User.create!(
          nickname: 'Joao',
          email: 'joao@gmail.com',
          password: '123456',
          cpf: '52996330250'
        )

        blocked_cpf = BlockedCpf.new(valid_attributes.merge(blocked_by: user))

        expect(blocked_cpf.blocked_by.admin?).to be false
        expect(blocked_cpf).to_not be_valid
        expect(blocked_cpf.errors[:blocked_by]).to include('deve ser um administrador')
      end
    end

    context 'uniqueness' do
      it 'valid' do
        BlockedCpf.create!(valid_attributes.merge(cpf: '94462646690'))
        blocked_cpf = BlockedCpf.new(valid_attributes.merge(cpf: '51483475034'))

        expect(blocked_cpf).to be_valid
      end

      it 'invalid' do
        blocked_cpf1 = BlockedCpf.create!(valid_attributes.merge(cpf: '80893978329'))
        blocked_cpf2 = BlockedCpf.new(valid_attributes.merge(cpf: '80893978329'))

        expect(blocked_cpf1.cpf).to eq blocked_cpf2.cpf
        expect(blocked_cpf2).to_not be_valid
        expect(blocked_cpf2.errors[:cpf]).to include('já está em uso')
      end
    end

    context 'presence' do
      it 'valid' do
        blocked_cpf = BlockedCpf.new(
          cpf: '80893978329',
          reason: 'Comportamento inadequado',
          blocked_by: User.create!(
            nickname: 'Ronaldo',
            email: 'fenomeno@leilaodogalpao.com.br',
            password: '123456',
            cpf: '69142235219'
          )
        )

        expect(blocked_cpf).to be_valid
      end

      context 'invalid' do
        it 'CPF' do
          blocked_cpf = BlockedCpf.new(valid_attributes.merge(cpf: nil))

          expect(blocked_cpf).to_not be_valid
          expect(blocked_cpf.errors[:cpf]).to include('não pode ficar em branco')
        end

        it 'blocked_by' do
          blocked_cpf = BlockedCpf.new(valid_attributes.merge(blocked_by: nil))

          expect(blocked_cpf).to_not be_valid
          expect(blocked_cpf.errors[:blocked_by]).to include('é obrigatório(a)')
        end
      end
    end
  end
end
