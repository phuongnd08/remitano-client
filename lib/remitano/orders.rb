require_relative "collection"
module Remitano
  class Orders < Remitano::Collection
    def sell(params = {})
      create params.merge(side: "sell")
    end

    def buy(params = {})
      create params.merge(side: "buy")
    end

    def cancel(order_id)
      Remitano::Helper.parse_object Remitano::Net::post("/orders/#{order_id}/cancel")
    end
  end
end
