require_relative "collection"
module Remitano
  class Executions < Remitano::Collection
    def all(order_id:)
      Remitano::Net.get("/orders/#{order_id}/executions").execute
    end
  end
end
