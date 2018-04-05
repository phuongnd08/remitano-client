require_relative "coin_collection"

module Remitano
  class Orders < Remitano::CoinCollection
    def self.open(pair, side)
      Remitano::Net.get("/orders/open?pair=#{pair}&side=#{side}").execute
    end

    def self.cancel(id)
      Remitano::Net.post("/orders/#{id}/cancel").execute
    end

    def self.create(pair:, side:, price:, amount:)
      Remitano::Net.post(
        "/orders",
        pair: pair, side: side, price: price, amount: amount
      ).execute
    end
  end
end
