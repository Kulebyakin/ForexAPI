class Api::V1::AccountsController < Api::V1::BaseController
  before_action :set_account, only: [:show, :update, :destroy]

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /accounts
  def index
    @accounts = policy_scope(Account.where(user: current_user))

    render json: @accounts
  end

  # GET /accounts/1
  def show
    render json: @account
  end

  # POST /accounts
  def create
    @account = Account.new(account_params)
    authorize @account

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
      authorize @account
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:amount, :user_id, :currency_id)
    end
end
