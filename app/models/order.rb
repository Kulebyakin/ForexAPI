class Order < ApplicationRecord
  belongs_to :user
  belongs_to :from_account, class_name: 'Account'
  belongs_to :to_account, class_name: 'Account'

  validates :from_account_id, presence: true
  validates :to_account_id, presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :desired_exchange_rate, presence: true
  validates :expiry_date, presence: true

  validate :from_account_and_to_account_must_be_different
  validate :expiry_date_cannot_be_in_the_past


  include AASM

  aasm(:status) do
    state :created, initial: true
    state :filled
    state :pending
    state :expired
    state :canceled

    event :expire do
      transitions from: :created, to: :expired
      transitions from: :pending, to: :expired
    end

    event :pend do
      transitions from: :created, to: :pending
    end

    event :fill do
      transitions from: :created, to: :filled
      transitions from: :pending, to: :filled
    end

    event :cancel do
      transitions from: :created, to: :canceled
      transitions from: :pending, to: :canceled
    end

  end


  def expiry_date_cannot_be_in_the_past
    if expiry_date.present? && expiry_date < Time.now
      errors.add(:expiry_date, "can't be in the past")
    end
  end

  def from_account_and_to_account_must_be_different
    if from_account == to_account
      errors.add(:from_account, "Choose different accounts")
      errors.add(:to_account, "Choose different accounts")
    end
  end
end
