require_relative "../collection"
module Remitano
  module Public
    class Offers < Remitano::Collection
      def offers(params = {} )
        Remitano::Net.public_get("/offers", params).execute.offers
      end

      def buy_offers(params = {})
        params[:offer_type] = "buy"
        offers(params)
      end

      def sell_offers(params = {})
        params[:offer_type] = "sell"
        offers(params)
      end
    end
  end
end
