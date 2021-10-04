class Account < ApplicationRecord
  belongs_to :user
  belongs_to :currency
  has_many :from_order, class_name: 'Order', inverse_of: :from_account, foreign_key: "from_account_id"
  has_many :to_order, class_name: 'Order', inverse_of: :to_account, foreign_key: "to_account_id"

  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
