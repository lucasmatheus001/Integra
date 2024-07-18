class Payment < ApplicationRecord
  belongs_to :user
  validates :amount, presence: true
  validates :approved, presence: true
  validates :user_id, presence: true
end
