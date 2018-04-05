require_relative "coin_collection"
module Remitano
  class Trades < Remitano::CoinCollection
    def active(buy_or_sell, page: nil)
      options = { trade_type: buy_or_sell, trade_status: "active", coin_currency: coin }
      (options[:page] = page) if page
      Remitano::Net.get("/trades?#{options.to_query}").execute
    end

    def closed(buy_or_sell, page: nil)
      options = { trade_type: buy_or_sell, trade_status: "closed", coin_currency: coin }
      (options[:page] = page) if page
      Remitano::Net.get("/trades?#{options.to_query}").execute
    end

    def release(trade_ref)
      response = Remitano::Net.post("/trades/#{trade_ref}/release").execute
      Remitano::ActionConfirmations.confirm_if_neccessary!(response)
    end

    def dispute(trade_ref)
      Remitano::Net.post("/trades/#{trade_ref}/dispute").execute
    end

    def mark_as_paid(trade_ref)
      Remitano::Net.post("/trades/#{trade_ref}/mark_as_paid").execute
    end

    def get(id)
      Remitano::Net.get("/trades/#{id}").execute.trade
    end

    def cancel(id)
      Remitano::Net.post("/trades/#{id}/cancel").execute
    end
  end
end
