require 'rails_helper'

RSpec.describe Currency, type: :model do

  it 'Has a title' do
    currency = Currency.new(
      title: '', 
      ticker: 'USD'
    )
    expect(currency).to_not be_valid

    currency.title = 'United States Dollar'
    expect(currency).to be_valid
  end

  it 'Has a ticker' do
    currency = Currency.new(
      title: 'United States Dollar', 
      ticker: ''
    )

    expect(currency).to_not be_valid
    currency.ticker = 'USD'
    expect(currency).to be_valid
  end
end




