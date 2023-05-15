class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :bids
  has_many :favorites
  has_many :favorite_lots, through: :favorites, source: :lot
  before_validation :set_admin_status_based_on_email_domain
  validates :nickname, :cpf, presence: true
  validates :nickname, :cpf, uniqueness: true
  validate :cpf_must_be_valid

  def cpf_valid?(cpf) # Código do CodeSaga
    return false if cpf.match(/^(.)\1*$/) # Elimina falsos positivos: 999.999.999-99, 888.888.888-88 ...

    cpf_valido = cpf.chars.map(&:to_i)[0..8]

    for i in 1..2 do
        soma_multiplicacao = cpf_valido.map.with_index {|n, index| n * (cpf_valido.size + 1 - index)}.sum
        cpf_valido << (((11 - soma_multiplicacao % 11) > 9) ? 0 : (11 - soma_multiplicacao % 11))
    end

    cpf_valido == cpf.chars.map(&:to_i)
  end

  private

  def cpf_must_be_valid
    errors.add(:cpf, 'não é válido') unless cpf_valid?(cpf)
  end

  def set_admin_status_based_on_email_domain
    self.admin = email.include?('@leilaodogalpao.com.br') if new_record?
  end

end
