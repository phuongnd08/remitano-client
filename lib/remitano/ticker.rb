module Remitano
  def self.ticker
    Remitano::Net.get("/price_ladders/ticker").execute
  end
end

