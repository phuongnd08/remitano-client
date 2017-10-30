require_relative "coin_collection"
module Remitano
  class Offers < Remitano::CoinCollection
    def my_offers(side)
      Remitano::Net.get("/offers/my_offers?offer_type=#{side}&coin_currency=#{coin}").execute.offers
    end

    def update(offer_id, params)
      response = Remitano::Net.patch("/offers/#{offer_id}", params).execute
      Remitano.action_confirmations.confirm_if_neccessary!(response)
    end

    def enable(offer_id)
      Remitano::Net.patch("/offers/#{offer_id}/enable").execute
    end

    def disable(offer_id)
      Remitano::Net.patch("/offers/#{offer_id}/disable").execute
    end
  end
end
