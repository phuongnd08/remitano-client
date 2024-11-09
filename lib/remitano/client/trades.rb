require_relative "coin_collection"
module Remitano
  class Client::Trades < Client::CoinCollection
    def active(buy_or_sell, page: nil)
      options = { trade_type: buy_or_sell, trade_status: "active", coin_currency: coin }
      (options[:page] = page) if page
      api_config = { api_version: "v3" }
      config.net.get("/trades?#{options.to_query}", {}, api_config).execute
    end

    def completed(buy_or_sell, page: nil)
      options = { trade_type: buy_or_sell, trade_status: "completed", coin_currency: coin }
      (options[:page] = page) if page
      api_config = { api_version: "v3" }
      config.net.get("/trades?#{options.to_query}", {}, api_config).execute
    end

    def release(trade_ref)
      response = config.net.post("/trades/#{trade_ref}/release").execute
      config.action_confirmations.confirm_if_neccessary!(response)
    end

    def dispute(trade_ref)
      config.net.post("/trades/#{trade_ref}/dispute").execute
    end

    def mark_as_paid(trade_ref)
      config.net.post("/trades/#{trade_ref}/mark_as_paid").execute
    end

    def get(id)
      config.net.get("/trades/#{id}").execute.trade
    end

    def cancel(id)
      config.net.post("/trades/#{id}/cancel").execute
    end
  end
end
