class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :lot

  validates :user, uniqueness: { scope: :lot }
end

