class OrderSerializer < ActiveModel::Serializer
  attributes :id, :amount, :desired_exchange_rate, :expiry_date, :status
  has_one :user
  has_one :from_account
  has_one :to_account
end
