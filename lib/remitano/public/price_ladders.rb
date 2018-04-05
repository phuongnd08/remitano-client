module Remitano
  module Public
    class PriceLadders
      def self.fetch(pair)
        Remitano::Net.public_get("/price_ladders/#{pair}").execute
      end
    end
  end
end
