require_relative "collection"
module Remitano
  class Orders < Remitano::Collection
    def all
      super.orders
    end

    def live
      Remitano::Net.get("/orders/live").execute.orders
    end

    def filled
      Remitano::Net.get("/orders/filled").execute.orders
    end

    def cancelled
      Remitano::Net.get("/orders/cancelled").execute.orders
    end

    def get(*ids)
      return [] if ids.empty?
      result = Remitano::Net.get("/orders/#{ids.join(",")}").execute
      result.orders || result
    end

    def cancel(*ids)
      return [] if ids.empty?
      Remitano::Net.post("/orders/#{ids.join(",")}/cancel").execute
    end
  end
end
