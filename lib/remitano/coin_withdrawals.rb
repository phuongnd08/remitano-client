require_relative "coin_collection"

module Remitano
  class CoinWithdrawals < Remitano::CoinCollection
    attr_reader :coin

    def initialize(coin)
      @coin = coin
    end

    def my_withdrawals
      Remitano::Net.get("/coin_withdrawals?coin_currency=#{coin}").execute
    end

    def cancel(id)
      Remitano::Net.post("/coin_withdrawals/#{id}/cancel").execute
    end

    def withdraw(coin_address, btc_amount)
      params = {
        coin_address: coin_address,
        coin_currency: coin,
        coin_amount: btc_amount
      }
      response = Remitano::Net.post("/coin_withdrawals", coin_withdrawal: params).execute
      Remitano::ActionConfirmations.confirm_if_neccessary!(response)
    end
  end
end
