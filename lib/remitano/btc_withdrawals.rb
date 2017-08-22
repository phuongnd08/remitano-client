require_relative "collection"

module Remitano
  class BtcWithdrawals< Remitano::Collection
    def my_withdrawals
      Remitano::Net.get("/coin_withdrawals?coin_currency=btc").execute
    end

    def cancel(id)
      Remitano::Net.post("/coin_withdrawals/#{id}/cancel").execute
    end

    def withdraw(coin_address, btc_amount)
      params = {
        coin_address: coin_address,
        coin_currency: "btc",
        coin_amount: btc_amount
      }
      response = Remitano::Net.post("/coin_withdrawals", coin_withdrawal: params).execute
      Remitano.action_confirmations.confirm_if_neccessary!(response)
    end
  end
end
