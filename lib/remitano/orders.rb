require_relative "coin_collection"

module Remitano
  class Orders
    attr_reader :remitano

    def initialize(remitano: nil)
      @remitano = remitano || Remitano.singleton
    end

    def open(pair, **params)
      remitano.net.get("/orders/open?pair=#{pair}&#{params.to_query}").execute
    end

    def cancel(id)
      remitano.net.post("/orders/#{id}/cancel").execute
    end

    def create(pair:, side:, price:, amount:)
      remitano.net.post(
        "/orders",
        pair: pair, side: side, price: price, amount: amount
      ).execute
    end
  end
end
