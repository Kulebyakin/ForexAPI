class Order < ApplicationRecord
  belongs_to :user
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  validates :from_account, presence: true
  validates :to_account, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :desired_exchange_rate, presence: true
  validates :expiry_date, presence: true
end
