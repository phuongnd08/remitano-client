module Remitano
  class Client::PriceLadders
    def fetch(pair)
      Remitano::Client::Net.public_get("/price_ladders/#{pair}").execute
    end
  end
end
