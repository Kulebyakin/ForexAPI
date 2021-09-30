class Account < ApplicationRecord
  belongs_to :user
  belongs_to :currency
  has_many :from_order, class_name: 'Order', inverse_of: :from_account
  has_many :to_order, class_name: 'Order', inverse_of: :to_account

  validates :amount, presence: true
end
