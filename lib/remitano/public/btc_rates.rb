require_relative "../collection"
module Remitano
  module Public
    class BtcRates
      def fetch
        Remitano::Net.public_get("/btc_rates/fetch").execute
      end
    end
  end
end
