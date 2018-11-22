require_relative "coin_collection"

module Remitano
  class CoinWithdrawals < Remitano::CoinCollection
    def my_withdrawals
      config.net.get("/coin_withdrawals?coin_currency=#{coin}").execute
    end

    def cancel(id)
      config.net.post("/coin_withdrawals/#{id}/cancel").execute
    end

    def withdraw(coin_address, coin_amount)
      params = {
        coin_address: coin_address,
        coin_currency: coin,
        coin_amount: coin_amount
      }
      response = config.net.post("/coin_withdrawals", coin_withdrawal: params).execute
      config.action_confirmations.confirm_if_neccessary!(response)
    end
  end
end
