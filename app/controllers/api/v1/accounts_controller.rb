module Api
  module V1
    class AccountsController < ApplicationController
      before_action :set_account, only: [:show, :update, :destroy]
    
      # GET /accounts
      def index
        @accounts = Account.all
    
        render json: @accounts
      end
    
      # GET /accounts/1
      def show
        render json: @account
      end
    
      # POST /accounts
      def create
        @account = Account.new(account_params)
    
        if @account.save
          render json: @account, status: :created
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end
    
      # PATCH/PUT /accounts/1
      def update
        if @account.update(account_params)
          render json: @account
        else
          render json: @account.errors, status: :unprocessable_entity
        end
      end
    
      # DELETE /accounts/1
      def destroy
        @account.destroy
      end
    
      private
        # Use callbacks to share common setup or constraints between actions.
        def set_account
          @account = Account.find(params[:id])
        end
    
        # Only allow a list of trusted parameters through.
        def account_params
          params.require(:account).permit(:amount, :user_id, :currency_id)
        end
    end
    
  end
end
