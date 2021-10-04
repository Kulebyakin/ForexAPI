class OrderWorker
  include Sidekiq::Worker

  sidekiq_options retry: 0

  def perform(id)
    order = Order.find(id)
    if Time.now >= order.expiry_date
      order.expire
      order.save
    else
      response =  RestClient.get "https://www.alphavantage.co/query?"\
        "function=CURRENCY_EXCHANGE_RATE&"\
        "from_currency=#{order.to_account.currency.ticker}&"\
        "to_currency=#{order.from_account.currency.ticker}&"\
        "apikey=#{Rails.application.credentials.alphavantage_apikey}", 
        {content_type: :json, accept: :json}

      current_exchange_rate = JSON.parse(
        response.body)["Realtime Currency Exchange Rate"]["5. Exchange Rate"].to_f

      if order.desired_exchange_rate < current_exchange_rate
        OrderWorker.perform_at(15.minutes.from_now, id)
      else
        from_account = Account.find(order.from_account_id)
        to_account = Account.find(order.to_account_id)

        new_amount_from_account = from_account.amount - order.amount * current_exchange_rate
        if new_amount_from_account < 0
          order.pend
          order.save
        else
          from_account.update(amount: new_amount_from_account)
          to_account.update(amount: to_account.amount + order.amount)

          order.fill
          order.save
        end
      end
    end
  end
end
