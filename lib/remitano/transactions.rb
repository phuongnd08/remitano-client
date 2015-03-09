module Remitano
  class UserTransactions < Remitano::Collection
    def all(options = {})
      # Default time delta to an hour
      options[:timedelta] = "3600" unless options[:timedelta]

      Remitano::Helper.parse_objects! Remitano::Net::post("/user_transactions", options).to_str, self.model
    end

    def find(order_id)
      all = self.all
      index = all.index {|order| order.id.to_i == order_id}

      return all[index] if index
    end

    def create(options = {})
    end

    def update(options={})
    end
  end
end
