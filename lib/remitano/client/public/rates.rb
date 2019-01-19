require_relative "../collection"
module Remitano
  class Client::Rates
    def ads
      Remitano::Client::Net.public_get("/rates/ads").execute
    end

    def exchange
      Remitano::Client::Net.public_get("/rates/exchange").execute
    end
  end
end
