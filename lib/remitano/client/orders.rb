require_relative "coin_collection"

module Remitano
  class Client::Orders
    attr_reader :config

    def initialize(config:)
      @config = config
    end

    def open(pair, **params)
      config.net.get("/orders/open?pair=#{pair}&#{params.to_query}").execute
    end

    def cancel(id)
      config.net.post("/orders/#{id}/cancel").execute
    end

    def create(pair:, side:, price:, amount:)
      config.net.post(
        "/orders",
        pair: pair, side: side, price: price, amount: amount
      ).execute
    end
  end
end
