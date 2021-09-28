module Api
  module V1
    class CurrencyController < ApplicationController
      before_action :authenticate_user!

      def index
        @currencies = Currency.all
    
        render json: @currencies
      end
    end
  end
end
