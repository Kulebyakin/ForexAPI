class Api::V1::CurrencyController < Api::V1::BaseController
  def index
    @currencies = Currency.all

    render json: @currencies
  end
end