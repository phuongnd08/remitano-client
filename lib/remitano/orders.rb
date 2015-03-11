require_relative "collection"
module Remitano
  class Orders < Remitano::Collection
    def sell(params = {})
      create params.merge(side: "sell")
    end

    def buy(params = {})
      create params.merge(side: "buy")
    end

    def get(*ids)
      return [] if ids.empty?
      Remitano::Helper.parse_array Remitano::Net::get("/orders/#{ids.join(",")}")
    end

    def cancel(*ids)
      return [] if ids.empty?
      Remitano::Helper.parse_array Remitano::Net::post("/orders/#{ids.join(",")}/cancel")
    end
  end
end
