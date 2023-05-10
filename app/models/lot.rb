class Lot < ApplicationRecord
  has_many :items
  belongs_to :creator, class_name: 'User'
  belongs_to :approver, class_name: 'User', optional: true
end
