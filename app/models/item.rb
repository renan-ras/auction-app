class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :lot, optional: true
  validates :code, uniqueness: true
  before_validation :generate_code, on: :create

  validate :validate_lot_id, on: :update, if: -> { lot_id_changed? }

  private

  def generate_code
    loop do
      self.code = SecureRandom.alphanumeric(10).upcase
      break unless Item.exists?(code: code) #Código único
    end
  end

  def validate_lot_id #Condições de aprovação: Lote_anterior(nil, pending ou canceled) E Lote_atual(nil ou pending)
    lot = Lot.find(lot_id) if lot_id.present?
    if lot_id_was.nil?
      errors.add(:lot_id, 'O lote atual não está habilitado para edição') unless lot.pending_approval?
    else
      lot_was = Lot.find(lot_id_was)
      errors.add(:lot_id, 'Alteração de lotes não permitida') unless (lot_was.pending_approval? || lot_was.canceled?) && (lot_id.nil? || lot.pending_approval?)
    end
  end

end
