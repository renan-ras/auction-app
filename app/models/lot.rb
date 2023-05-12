class Lot < ApplicationRecord
  enum status: { pending_approval: 1, approved: 3, sold: 6, canceled: 8 }
  has_many :items
  belongs_to :creator, class_name: 'User'
  belongs_to :approver, class_name: 'User', optional: true
  
  validates :code, presence: true, uniqueness: true, format: { with: /\A[A-Z]{3}\d{6}\z/, message: "Formato: 3 letras maiúsculas seguidas por 6 números (ex.: XYZ369258)" }

  validates :minimum_bid, presence: true, numericality: { greater_than: 0 }
  validates :minimum_bid_increment, presence: true, numericality: { greater_than: 0 }

  validates :start_date, presence: true, comparison: { greater_than: Time.now }
  validates :end_date, presence: true, comparison: { greater_than: :start_date } # Testar se (:start_date + 24.hours) funciona.

  validate :validate_approval, on: :update, if: -> { approver_id_changed? }

  def self.available_items
    Item.where(lot_id: nil)
  end

  private

  def validate_approval
    if approver_id_was.present?
      errors.add(:approver, "não pode ser alterado após o lote estar aprovado")
    elsif approver_id == creator_id
      errors.add(:base, "Você não pode aprovar um lote que criou")
    end
  end

end
