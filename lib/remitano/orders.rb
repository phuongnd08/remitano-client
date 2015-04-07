require_relative "collection"
module Remitano
  class Orders < Remitano::Collection
    def all
      super.orders
    end

    def sell(params = {})
      create params.merge(side: "sell")
    end

    def buy(params = {})
      create params.merge(side: "buy")
    end

    def get(*ids)
      return [] if ids.empty?
      Remitano::Net.get("/orders/#{ids.join(",")}").execute
    end

    def cancel(*ids)
      return [] if ids.empty?
      Remitano::Net.post("/orders/#{ids.join(",")}/cancel").execute
    end
  end
end
