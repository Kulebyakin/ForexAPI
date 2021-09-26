require "rails_helper"
RSpec.describe "Account", :type => :request do
before(:each) do
    @user = FactoryBot.create(:user) 
    @currency = FactoryBot.create(:currency)
    @create_accaount_url = '/api/v1/accounts'
    @account_params = {
      amount: 23.9, 
      user_id: 1, 
      currency_id: 1
    }
    @invalid_account_params = {
      amount: '', 
      user_id: '', 
      currency_id: ''
    }
  end
describe 'POST /api/v1/accounts' do
context 'when account params is valid' do
      before do
        post @create_accaount_url, params: @account_params, as: :json
      end
it 'returns status 201' do
      expect(response).to have_http_status(201)
    end
  end
context 'when account params is invalid' do
    before { post @create_accaount_url, params: @invalid_account_params, as: :json }
it 'returns unathorized status 401' do
      expect(response.status).to eq 422
    end
  end
end
end