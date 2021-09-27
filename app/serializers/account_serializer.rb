class AccountSerializer < ActiveModel::Serializer
  attributes :id, :amount
  belongs_to :currency
end
