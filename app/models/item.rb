class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :lot, optional: true
  validates :code, uniqueness: true
  before_validation :generate_code, on: :create

  private

  def generate_code
    loop do
      self.code = SecureRandom.alphanumeric(10).upcase
      break unless Item.exists?(code: code)
    end
  end
end
