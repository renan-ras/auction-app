class Lot < ApplicationRecord
  enum status: { pending_approval: 1, approved: 3, sold: 6, canceled: 8 }
  has_many :items
  has_many :bids
  belongs_to :creator, class_name: 'User'
  belongs_to :approver, class_name: 'User', optional: true
  
  validates :code, presence: true, uniqueness: true, format: { with: /\A[A-Z]{3}\d{6}\z/, message: "Formato: 3 letras maiúsculas seguidas por 6 números (ex.: XYZ369258)" }
  validates :minimum_bid, presence: true, numericality: { greater_than: 0 }
  validates :minimum_bid_increment, presence: true, numericality: { greater_than: 0 }
  validates :start_date, presence: true, comparison: { greater_than: Time.now }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }

  validate :validate_approval, on: :update, if: -> { approver_id_changed? }
  validate :status_transition_validation, on: :update, if: -> { status_changed? }
  before_destroy :prevent_deletion_if_not_pending_approval



  def self.available_items
    Item.where(lot_id: nil)
  end

  def open_for_bids?
    approved? && Time.now.between?(start_date, end_date)
  end

  private

  def validate_approval
    if approver_id_was.present?
      errors.add(:approver, "não pode ser alterado após o lote estar aprovado")
    elsif approver_id == creator_id
      errors.add(:base, "Você não pode aprovar um lote que criou")
    end
  end

  def status_transition_validation
    case status_was
    when "pending_approval"
      errors.add(:status, "deve ser 'aprovado' quando o status anterior é 'aguardando aprovação'") unless %w[approved].include?(status)
    when "approved"
      errors.add(:status, "deve ser 'vendido' ou 'cancelado' quando o status anterior é 'aprovado'") unless %w[sold canceled].include?(status)
    when "sold", "canceled"
      errors.add(:status, "não pode ser alterado quando o status anterior é 'vendido' ou 'cancelado'")
    end
  end

  def prevent_deletion_if_not_pending_approval
    if status != "pending_approval"
      errors.add(:base, "Lotes com status diferente de 'aguardando aprovação' não podem ser deletados")
      throw(:abort)
    end
  end

end
