require_relative "../collection"
module Remitano
  module Public
    class CoinRates
      def fetch
        Remitano::Net.public_get("/btc_rates/fetch").execute
      end

      def exchanges
        Remitano::Net.public_get("/btc_rates/fetch_exchange").execute
      end
    end
  end
end
