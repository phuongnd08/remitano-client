require_relative "../collection"
module Remitano
  module Public
    class CoinRates
      def self.fetch
        Remitano::Net.public_get("/btc_rates/fetch").execute
      end

      def self.exchanges
        Remitano::Net.public_get("/btc_rates/fetch_exchange").execute
      end
    end
  end
end
