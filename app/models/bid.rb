class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validate :lot_open_for_bids, :user_not_admin, :amount_meets_minimum

  private

  def lot_open_for_bids
    errors.add(:lot, 'não está aberto para lances') unless lot.auction_open_for_bids?
  end

  def user_not_admin
    errors.add(:user, 'admins não podem fazer lances') if user.admin?
  end

  def amount_meets_minimum
    return unless lot.present? & amount.present?

    if lot.bids.count == 0
      errors.add(:amount, 'O lance deve ser maior ou igual ao lance mínimo') if amount < lot.minimum_bid
    else
      min_amount = lot.bids.maximum(:amount) + lot.minimum_bid_increment
      errors.add(:amount, 'O lance deve ser maior ou igual ao maior lance + incremento mínimo') if amount < min_amount
    end
  end
end
