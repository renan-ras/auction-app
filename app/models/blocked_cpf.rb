class BlockedCpf < ApplicationRecord
  belongs_to :blocked_by, class_name: 'User'
  has_one :user, primary_key: :cpf, foreign_key: :cpf
  validates :cpf, presence: true, uniqueness: true
  validate :blocked_by_must_be_admin

  private

  def blocked_by_must_be_admin
    errors.add(:blocked_by, "deve ser um administrador") unless blocked_by&.admin?
  end
end
