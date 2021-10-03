class Account < ApplicationRecord
  belongs_to :user
  belongs_to :currency
  has_many :from_order, class_name: 'Order', inverse_of: :from_account
  has_many :to_order, class_name: 'Order', inverse_of: :to_account

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
