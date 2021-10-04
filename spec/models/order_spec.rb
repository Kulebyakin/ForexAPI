require 'rails_helper'

RSpec.describe Order, type: :model do
  before(:each) do
    @user = FactoryBot.create(:user) 
    @account = FactoryBot.create_list(:account, 2)
  end

  it 'Has a amount greater than or equal to 1' do
    order = Order.new(
      amount: '', 
      user_id: @user.id,
      from_account_id: @account[0].id,
      to_account_id: @account[1].id,
      desired_exchange_rate: 1.2,
      expiry_date: Time.now + 1.day
    )
    expect(order).to_not be_valid

    order.amount = -1
    expect(order).to_not be_valid

    order.amount = 1
    expect(order).to be_valid
  end

  it 'Has a user' do
    order = Order.new(
      amount: 1, 
      user_id: '',
      from_account_id: @account[0].id,
      to_account_id: @account[1].id,
      desired_exchange_rate: 1.2,
      expiry_date: Time.now + 1.day
    )
    expect(order).to_not be_valid

    order.user_id = @user.id
    expect(order).to be_valid
  end

  it 'Has from_account and to_account and not equal to each other' do
    order = Order.new(
      amount: 1, 
      user_id: @user.id,
      from_account_id: '',
      to_account_id: '',
      desired_exchange_rate: 1.2,
      expiry_date: Time.now + 1.day
    )
    expect(order).to_not be_valid

    order.from_account_id = @account[0].id
    order.to_account_id = @account[0].id
    expect(order).to_not be_valid

    order.from_account_id = @account[0].id
    order.to_account_id = @account[1].id
    expect(order).to be_valid
  end

  it 'Has a desired_exchange_rate' do
    order = Order.new(
      amount: 1, 
      user_id: @user.id,
      from_account_id: @account[0].id,
      to_account_id: @account[1].id,
      desired_exchange_rate: '',
      expiry_date: Time.now + 1.day
    )
    expect(order).to_not be_valid

    order.desired_exchange_rate = 1.2
    expect(order).to be_valid
  end

  it 'Has a expiry_date not in the past' do
    order = Order.new(
      amount: 1, 
      user_id: @user.id,
      from_account_id: @account[0].id,
      to_account_id: @account[1].id,
      desired_exchange_rate: 1.2,
      expiry_date: ''
    )
    expect(order).to_not be_valid

    order.expiry_date = Time.now - 1.day
    expect(order).to_not be_valid

    order.expiry_date = Time.now + 1.day
    expect(order).to be_valid
  end
end
