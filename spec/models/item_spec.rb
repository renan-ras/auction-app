require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:valid_attributes) do
    {
      name: 'Item Name',
      description: 'Item Description',
      weight: 100,
      width: 10,
      height: 10,
      depth: 10,
      category: 'Eletrônicos'
    }
  end

  describe 'code generation' do
    it 'generates a 10-character alphanumeric code' do
      item = Item.create!(valid_attributes)
      expect(item.code).to match(/\A[A-Z0-9]{10}\z/)
    end
  end

  describe 'validations' do
    it 'is invalid without a name' do
      item = Item.new(valid_attributes.merge(name: nil))
      expect(item).to_not be_valid
    end

    it 'is invalid without a category' do
      item = Item.new(valid_attributes.merge(category: nil))
      expect(item).to_not be_valid
    end

    it 'is invalid without a description' do
      item = Item.new(valid_attributes.merge(description: nil))
      expect(item).to_not be_valid
    end

    it 'is invalid with a weight of zero' do
      item = Item.new(valid_attributes.merge(weight: 0))
      expect(item).to_not be_valid
    end

    it 'is invalid with a weight less than zero' do
      item = Item.new(valid_attributes.merge(weight: -1))
      expect(item).to_not be_valid
    end

    it 'is invalid with a width of zero' do
      item = Item.new(valid_attributes.merge(width: 0))
      expect(item).to_not be_valid
    end

    it 'is invalid with a width less than zero' do
      item = Item.new(valid_attributes.merge(width: -1))
      expect(item).to_not be_valid
    end

    it 'is invalid with a height of zero' do
      item = Item.new(valid_attributes.merge(height: 0))
      expect(item).to_not be_valid
    end

    it 'is invalid with a height less than zero' do
      item = Item.new(valid_attributes.merge(height: -1))
      expect(item).to_not be_valid
    end

    it 'is invalid with a depth of zero' do
      item = Item.new(valid_attributes.merge(depth: 0))
      expect(item).to_not be_valid
    end

    it 'is invalid with a depth less than zero' do
      item = Item.new(valid_attributes.merge(depth: -1))
      expect(item).to_not be_valid
    end
  end
end
