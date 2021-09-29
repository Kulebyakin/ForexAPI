class Currency < ApplicationRecord
  has_many :accounts

  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :ticker, presence: true, uniqueness: { case_sensitive: false }
end
