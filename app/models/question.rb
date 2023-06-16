class Question < ApplicationRecord
  belongs_to :lot
  belongs_to :user
  belongs_to :answered_by, class_name: 'User', optional: true
  validates :content, :lot, :user, presence: true
  validate :answered_by_must_be_admin
  scope :visible, -> { where(hidden: false) }

  private

  def answered_by_must_be_admin
    errors.add(:answered_by, 'must be an admin') if answered_by.present? && !answered_by.admin?
  end
end
