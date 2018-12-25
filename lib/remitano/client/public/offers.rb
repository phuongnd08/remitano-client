require_relative "../collection"
module Remitano
  class Client::PublicOffers < Remitano::Client::Collection
    def offers(params = {} )
      Remitano::Client::Net.public_get("/offers", params).execute.offers
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
