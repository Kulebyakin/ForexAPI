require 'rails_helper'

RSpec.describe "/api/v1/orders", type: :request do
  before do
    user = FactoryBot.create(:user) 
    account = FactoryBot.create_list(:account, 2)
    @orders_url = '/api/v1/orders'
    @order_params = {
      amount: 1,
      user_id: user.id,
      from_account_id: account[0].id,
      to_account_id: account[1].id,
      desired_exchange_rate: 1.2,
      expiry_date: Time.now + 1.day
    }
    @invalid_order_params = {
      amount: 0,
      user_id: user.id,
      from_account_id: '',
      to_account_id: '',
      desired_exchange_rate: 0,
      expiry_date: ''
    }
    sign_in_url = '/auth/sign_in' 
    login_params = {
      email: user.email,
      password: user.password
    }
    post sign_in_url, params: login_params, as: :json
    @headers = response.headers
  end

  describe 'POST /api/v1/orders' do
    context 'when order params is valid' do
      before do
        post @orders_url, headers: @headers, params: @order_params, as: :json
      end
      it 'returns status 201' do
        expect(response).to have_http_status(201)
      end
    end
    context 'when order params is invalid' do
      before { post @orders_url, headers: @headers, params: @invalid_order_params, as: :json }
      it 'returns unathorized status 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET /api/v1/orders' do
    before do
      get @orders_url, headers: @headers, as: :json
    end
    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /api/v1/orders/1" do
    before do
      @order = Order.create! @order_params
    end
    it "renders a successful response" do
      get api_v1_orders_url(@order), headers: @headers, as: :json
      expect(response).to be_successful
    end
  end

  # describe "POST /create" do
  #   context "with valid parameters" do
  #     it "creates a new Order" do
  #       expect {
  #         post orders_url,
  #              params: { order: valid_attributes }, headers: valid_headers, as: :json
  #       }.to change(Order, :count).by(1)
  #     end

  #     it "renders a JSON response with the new order" do
  #       post orders_url,
  #            params: { order: valid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:created)
  #       expect(response.content_type).to match(a_string_including("application/json"))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "does not create a new Order" do
  #       expect {
  #         post orders_url,
  #              params: { order: invalid_attributes }, as: :json
  #       }.to change(Order, :count).by(0)
  #     end

  #     it "renders a JSON response with errors for the new order" do
  #       post orders_url,
  #            params: { order: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including("application/json"))
  #     end
  #   end
  # end

  # describe "PATCH /update" do
  #   context "with valid parameters" do
  #     let(:new_attributes) {
  #       skip("Add a hash of attributes valid for your model")
  #     }

  #     it "updates the requested order" do
  #       order = Order.create! valid_attributes
  #       patch order_url(order),
  #             params: { order: new_attributes }, headers: valid_headers, as: :json
  #       order.reload
  #       skip("Add assertions for updated state")
  #     end

  #     it "renders a JSON response with the order" do
  #       order = Order.create! valid_attributes
  #       patch order_url(order),
  #             params: { order: new_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:ok)
  #       expect(response.content_type).to match(a_string_including("application/json"))
  #     end
  #   end

  #   context "with invalid parameters" do
  #     it "renders a JSON response with errors for the order" do
  #       order = Order.create! valid_attributes
  #       patch order_url(order),
  #             params: { order: invalid_attributes }, headers: valid_headers, as: :json
  #       expect(response).to have_http_status(:unprocessable_entity)
  #       expect(response.content_type).to match(a_string_including("application/json"))
  #     end
  #   end
  # end

  # describe "DELETE /destroy" do
  #   it "destroys the requested order" do
  #     order = Order.create! valid_attributes
  #     expect {
  #       delete order_url(order), headers: valid_headers, as: :json
  #     }.to change(Order, :count).by(-1)
  #   end
  # end
end
