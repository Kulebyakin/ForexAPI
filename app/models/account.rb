class Account < ApplicationRecord
  belongs_to :user
  belongs_to :currency

  validates :amount, presence: true
end
