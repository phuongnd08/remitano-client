require_relative "collection"

module Remitano
  class BtcWithdrawals< Remitano::Collection
    def my_withdrawals
      Remitano::Net.get("/btc_withdrawals").execute
    end

    def withdraw(btc_address, btc_amount)
      params = {
        btc_address: btc_address,
        btc_amount: btc_amount
      }
      Remitano::Net.post("/btc_withdrawals", btc_withdrawal: params).execute
    end
  end
end
