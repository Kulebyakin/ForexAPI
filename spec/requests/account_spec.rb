require "rails_helper"
RSpec.describe "Account", :type => :request do
  before(:each) do
    user = FactoryBot.create(:user) 
    currency = FactoryBot.create(:currency)
    @accounts_url = '/api/v1/accounts'
    @account_params = {
      amount: 23.9, 
      user_id: user.id, 
      currency_id: currency.id
    }
    @sign_in_url = '/auth/sign_in' 
    @login_params = {
      email: user.email,
      password: user.password
    }
    post @sign_in_url, params: @login_params, as: :json
    @headers = response.headers
  end

  describe 'POST /api/v1/accounts' do
    context 'when account params is valid' do
      before do
        post @accounts_url, headers: @headers, params: @account_params, as: :json
      end
      it 'returns status 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when account params is invalid' do
      before { post @accounts_url, params: @invalid_account_params, as: :json }
      it 'returns unathorized status 401' do
          expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /api/v1/accounts' do
    before do
      get @accounts_url, headers: @headers, as: :json
    end
    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/accounts/1" do
    before do
      @account = Account.create! @account_params
    end
    it "renders a successful response" do
      get api_v1_accounts_url(@account), headers: @headers, as: :json
      expect(response).to be_successful
    end
  end

end