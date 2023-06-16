require 'rails_helper'

RSpec.describe Lot, type: :model do
  let(:valid_attributes) do
    {
      code: 'XYZ123456',
      start_date: 1.day.from_now,
      end_date: 10.days.from_now,
      minimum_bid: 100,
      minimum_bid_increment: 10,
      creator: User.create!(nickname: 'Ronaldo', email: 'fenomeno@leilaodogalpao.com.br', password: '123456',
                            cpf: '69142235219')
    }
  end

  describe 'validations' do
    context 'start_date' do
      it 'not past' do
        lot = Lot.new(valid_attributes.merge(start_date: 1.day.ago))
        expect(lot).to_not be_valid
        # expect(lot.errors.full_messages).to include("Data de início deve ser maior que #{Time.current}")
        # Time.current As vezes falha por causa de um segundo.
      end
    end

    context 'end_date' do
      it 'grater than start date' do
        start_date = 1.day.from_now
        end_date = start_date - 1.hour
        lot = Lot.new(valid_attributes.merge(start_date:, end_date:))
        expect(lot).to_not be_valid
        expect(lot.errors.full_messages).to include("Data de término deve ser maior que #{start_date}")
      end
    end

    context 'code' do
      it 'presence' do
        lot = Lot.new(valid_attributes.merge(code: ''))
        expect(lot).to_not be_valid
        expect(lot.errors.full_messages).to include('Código não pode ficar em branco')
        expect(lot.errors.full_messages).to include('Código Formato: 3 letras maiúsculas seguidas por 6 números (ex.: XYZ369258)')
      end

      it 'uniqueness' do
        Lot.create!(valid_attributes)
        duplicate_lot = Lot.new(valid_attributes)
        expect(duplicate_lot.valid?).to eq(false)
        expect(duplicate_lot.errors.full_messages).to include('Código já está em uso')
      end

      it 'format' do
        lot = Lot.new(valid_attributes.merge(code: '0AB234567'))
        expect(lot).to_not be_valid
        expect(lot.errors.full_messages).to include('Código Formato: 3 letras maiúsculas seguidas por 6 números (ex.: XYZ369258)')
      end
    end

    context 'creator' do
      it 'not admin' do
        user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456',
                              cpf: '94462646690')
        lot = Lot.new(valid_attributes.merge(creator: user_b))
        expect(lot).to_not be_valid
        expect(lot.errors.full_messages).to include('Criador deve ser um administrador')
      end
    end

    context 'approver' do
      it 'not admin' do
        user_b = User.create!(nickname: 'Richarlison', email: 'pombo@email.com.br', password: '123456',
                              cpf: '94462646690')
        lot = Lot.new(valid_attributes.merge(approver: user_b))
        expect(lot).to_not be_valid
        expect(lot.errors.full_messages).to include('Aprovador deve ser um administrador')
      end
    end
  end
end
