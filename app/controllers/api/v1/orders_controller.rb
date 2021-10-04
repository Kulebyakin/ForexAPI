class Api::V1::OrdersController < Api::V1::BaseController
  before_action :set_order, only: [:show, :destroy]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /orders
  def index
    @orders = policy_scope(Order.where(user: current_user))

    render json: @orders
  end

  # GET /orders/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(order_params)
    authorize @order

    if @order.save
      OrderWorker.perform_async(@order.id)

      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.cancel
    @order.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
      authorize @order
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(
        :user_id, 
        :from_account_id, 
        :to_account_id, 
        :amount, 
        :desired_exchange_rate, 
        :expiry_date)
    end
end
