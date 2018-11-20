require_relative "coin_collection"
module Remitano
  class Trades < Remitano::CoinCollection
    def active(buy_or_sell, page: nil)
      options = { trade_type: buy_or_sell, trade_status: "active", coin_currency: coin }
      (options[:page] = page) if page
      remitano.net.get("/trades?#{options.to_query}").execute
    end

    def completed(buy_or_sell, page: nil)
      options = { trade_type: buy_or_sell, trade_status: "completed", coin_currency: coin }
      (options[:page] = page) if page
      remitano.net.get("/trades?#{options.to_query}").execute
    end

    def release(trade_ref)
      response = remitano.net.post("/trades/#{trade_ref}/release").execute
      remitano.action_confirmations.confirm_if_neccessary!(response)
    end

    def dispute(trade_ref)
      remitano.net.post("/trades/#{trade_ref}/dispute").execute
    end

    def mark_as_paid(trade_ref)
      remitano.net.post("/trades/#{trade_ref}/mark_as_paid").execute
    end

    def get(id)
      remitano.net.get("/trades/#{id}").execute.trade
    end

    def cancel(id)
      remitano.net.post("/trades/#{id}/cancel").execute
    end
  end
end
