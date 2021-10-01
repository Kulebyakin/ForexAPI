class Order < ApplicationRecord
  belongs_to :user
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  validates :from_account, presence: true
  validates :to_account, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :desired_exchange_rate, presence: true
  validates :expiry_date, presence: true

  include AASM

  aasm(:status) do
    state :created, initial: true
    state :filled
    state :expired
    state :canceled

    event :expire do
      transitions from: :created, to: :expired
    end

    event :fill do
      transitions from: :created, to: :filled
    end

    event :cancel do
      transitions from: :created, to: :canceled
    end

  end
end
