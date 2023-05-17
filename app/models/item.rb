class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :lot, optional: true
  validates :code, uniqueness: true
  validates :name, :category, :description, presence: true
  validates :weight, :width, :height, :depth, presence: true, numericality: { greater_than: 0 }
  before_validation :generate_code, on: :create
  before_destroy :can_be_destroyed?

  validate :validate_lot_id, on: :update, if: -> { lot_id_changed? }
  validate :check_editable, on: :update

  def self.in_approved_lots
    joins(:lot).where(lots: { status: 'approved' })
  end

  def self.in_sold_lots
    joins(:lot).where(lots: { status: 'sold' })
  end

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

  def check_editable
    errors.add(:base, 'O item só pode ser editado se não estiver em um lote ou se o lote estiver aguardando aprovação.') if lot.present? && !lot.pending_approval?
  end

  def can_be_destroyed?
    return true if lot.nil? || lot.pending_approval?
    errors.add(:base, 'O item só pode ser excluído se não estiver em um lote ou se o lote estiver pendente de aprovação')
    throw :abort
  end

end
