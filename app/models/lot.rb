class Lot < ApplicationRecord
  enum status: { pending_approval: 1, approved: 3, sold: 6, canceled: 8 }
  has_many :items
  has_many :bids
  has_many :favorites
  has_many :favorited_by_users, through: :favorites, source: :user
  belongs_to :creator, class_name: 'User'
  belongs_to :approver, class_name: 'User', optional: true
  
  validates :code, presence: true, uniqueness: true, format: { with: /\A[A-Z]{3}\d{6}\z/, message: "Formato: 3 letras maiúsculas seguidas por 6 números (ex.: XYZ369258)" }
  validates :minimum_bid, presence: true, numericality: { greater_than: 0 }
  validates :minimum_bid_increment, presence: true, numericality: { greater_than: 0 }
  validates :start_date, presence: true
  validates :start_date, comparison: { greater_than: Time.now }, on: [:create, :update], unless: -> { status == 'sold' || status == 'canceled' }
  validates :end_date, presence: true, comparison: { greater_than: :start_date }

  validate :validate_approval, on: :update, if: -> { approver_id_changed? }
  validate :status_transition_validation, on: :update, if: -> { status_changed? }
  validate :at_least_one_item, on: :update, if: -> { status_changed? && status == 'approved' }

  before_destroy :prevent_deletion_if_not_pending_approval

  scope :future_auctions, -> { approved.where("start_date > ?", Time.now) }
  scope :open_auctions, -> { approved.where("start_date <= ? AND end_date >= ?", Time.now, Time.now) }

  def self.available_items
    Item.where(lot_id: nil)
  end

  def auction_ready?
    approved? && Time.now < start_date
  end

  def auction_open_for_bids?
    approved? && Time.now.between?(start_date, end_date)
  end

  def auction_ended?
    !pending_approval? && Time.now > end_date
  end

  def auction_status
    if auction_ready?
      'Não Iniciado'
    elsif auction_open_for_bids?
      'Em Andamento'
    elsif auction_ended?
      'Encerrado'
    else
      'Em Desenvolvimento'
    end
  end

  def highest_bid_with_user #ainda não usada
    highest_bid = bids.order(amount: :desc).first
    if highest_bid
      { user_name: highest_bid.user.nickname, amount: highest_bid.amount }
    else
      { user_name: nil, amount: nil }
    end
  end
  #<% highest_bid_info = @lot.highest_bid_with_user %>
  #<%= highest_bid_info[:user_name] %>

  def highest_bid #<%= number_to_currency(@lot.highest_bid) || 'Nenhum lance registrado' %>
    bids.maximum(:amount)
  end
  
  def highest_bid_user #<%= @lot.highest_bid_user || 'Nenhum' %>
    bids.order(amount: :desc).first&.user&.nickname
  end
  
  def next_minimum_bid #<%= number_to_currency(@lot.next_minimum_bid) %>
    highest_bid.present? ? highest_bid + minimum_bid_increment : minimum_bid
  end
  
  def auction_waiting_validation?
    approved? && Time.now > end_date
  end
  
  def lot_should_be_sold?
    auction_waiting_validation? && bids.count > 0
  end
  
  def lot_should_be_canceled?
    auction_waiting_validation? && bids.count == 0
  end
  
  def self.won_by_user(user)
    joins(:bids)
      .where(status: :sold)
      .group('lots.id')
      .having("MAX(bids.amount) = (SELECT MAX(b.amount) FROM bids b WHERE b.lot_id = lots.id) AND bids.user_id = ?", user.id)
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

  def at_least_one_item
    errors.add(:items, "O lote deve ter pelo menos um item para ser aprovado") if items.empty?
  end  

  def prevent_deletion_if_not_pending_approval
    if status != "pending_approval"
      errors.add(:base, "Lotes com status diferente de 'aguardando aprovação' não podem ser deletados")
      throw(:abort)
    end
  end

end
