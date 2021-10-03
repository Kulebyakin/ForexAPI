require 'rails_helper'

RSpec.describe "Currencies", type: :request do
  before(:each) do
    @user = FactoryBot.create(:user) 
    @currency = FactoryBot.create(:currency)
    @sign_in_url = '/auth/sign_in' 
    @login_params = {
        email: @user.email,
        password: @user.password
    }
    post @sign_in_url, params: @login_params, as: :json
    @headers = response.headers
  end
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/currency", headers: @headers
      expect(response).to have_http_status(:success)
    end
  end
  describe "GET /index without login" do
    it "returns http success" do
      get "/api/v1/currency"
      expect(response).to have_http_status(:unauthorized)
    end
  end

end
