module Remitano
  def self.price_ladders
    Remitano::Net.get("/price_ladders").execute
  end
end

