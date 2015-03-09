require_relative "collection"
module Remitano
  class Orders < Remitano::Collection
    def sell(params = {})
      create params.merge(side: "sell")
    end

    def buy(params = {})
      create params.merge(side: "buy")
    end

    def find(order_id)
      Remitano::Helper.parse_objects! Remitano::Net::get("/orders/#{order_id}").to_str, self.model
    end

    private

    def create(params)
      Remitano::Helper.parse_object! Remitano::Net::post("/orders", params).to_str, self.model
    end
  end
end
