require_relative "../collection"
module Remitano
  class Client::CoinRates
    def fetch
      Remitano::Client::Net.public_get("/btc_rates/fetch").execute
    end

    def exchanges
      Remitano::Client::Net.public_get("/btc_rates/fetch_exchange").execute
    end
  end
end
