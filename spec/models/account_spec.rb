require 'rails_helper'

RSpec.describe Account, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user) 
    @currency = FactoryBot.create(:currency)
  end

  it 'Has a amount greater than or equal to 0' do
    account = Account.new(
      amount: '', 
      user_id: @user.id, 
      currency_id: @currency.id
    )
    expect(account).to_not be_valid

    account.amount = -1
    expect(account).to_not be_valid

    account.amount = 1
    expect(account).to be_valid
  end

  it 'Has a currency' do
    account = Account.new(
      amount: 1, 
      user_id: @user.id, 
      currency_id: ''
    )

    expect(account).to_not be_valid
    account.currency_id = @currency.id
    expect(account).to be_valid
  end

  it 'Has a user' do
    account = Account.new(
      amount: 1, 
      user_id: '', 
      currency_id: @currency.id
    )

    expect(account).to_not be_valid
    account.user_id = @user.id
    expect(account).to be_valid
  end
end




