module Remitano
  class Orders < Remitano::Collection
    def all(options = {})
      Remitano::Helper.parse_objects! Remitano::Net::post('/open_orders').to_str, self.model
    end

    def create(options = {})
      path = (options[:type] == Remitano::Order::SELL ? "/sell" : "/buy")
      Remitano::Helper.parse_object! Remitano::Net::post(path, options).to_str, self.model
    end

    def sell(options = {})
      options.merge!({type: Remitano::Order::SELL})
      self.create options
    end

    def buy(options = {})
      options.merge!({type: Remitano::Order::BUY})
      self.create options
    end

    def find(order_id)
      all = self.all
      index = all.index {|order| order.id.to_i == order_id}

      return all[index] if index
    end
  end

  class Order < Remitano::Model
    BUY  = 0
    SELL = 1

    attr_accessor :type, :amount, :price, :id, :datetime
    attr_accessor :error, :message

    def cancel!
      Remitano::Net::post('/cancel_order', {id: self.id}).to_str
    end
  end
end
