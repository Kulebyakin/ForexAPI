require 'rails_helper'

RSpec.describe AccountPolicy, type: :policy do
  
  let(:user) { FactoryBot.create(:user) }
  let(:currency) { FactoryBot.create(:currency) }
  let(:account) { FactoryBot.create(:account) }
  
  subject { AccountPolicy.new(user, account) }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to forbid_actions(%i[index create update show destroy]) }
  end

  context 'being other user' do
    let(:user) { FactoryBot.create(:user) }

    it { is_expected.to forbid_actions(%i[index create update show destroy]) }
  end

  context 'being an author of account' do
    let(:user) { User.create id: 1, email: "user@example.com", password: "123123" }
    let(:account) { Account.create user_id: 1, currency_id: 1, amount: 30 }

    it { is_expected.to permit_actions(%i[create update show destroy]) }
  end

end
