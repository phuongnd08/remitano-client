module Remitano
  class Orders < Remitano::Collection
    def all(options = {})
      Remitano::Helper.parse_objects! Remitano::Net::get('/orders').to_str, self.model
    end

    def create(options = {})
      Remitano::Helper.parse_object! Remitano::Net::post("/orders", options).to_str, self.model
    end

    def sell(options = {})
      create options.merge(side: "sell")
    end

    def buy(options = {})
      create options.merge(side: "buy")
    end

    def find(order_id)
      Remitano::Helper.parse_objects! Remitano::Net::get("/orders/#{order_id}").to_str, self.model
    end
  end

  class Order < Remitano::Model
    attr_accessor :side, :type, :amount, :price, :id, :created_at, :updated_at
    attr_accessor :error, :message

    def cancel!
      Remitano::Net::put("/orders/#{id}/cancel").to_str
    end
  end
end
