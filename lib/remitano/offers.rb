require_relative "coin_collection"
module Remitano
  class Offers < Remitano::CoinCollection
    def my_offers(side)
      remitano.net.get("/offers/my_offers?offer_type=#{side}&coin_currency=#{coin}").execute.offers
    end

    def update(offer_id, params)
      response = remitano.net.patch("/offers/#{offer_id}?coin_currency=#{coin}", params).execute
      remitano.action_confirmations.confirm_if_neccessary!(response)
    end

    def enable(offer_id)
      remitano.net.patch("/offers/#{offer_id}/enable?coin_currency=#{coin}").execute
    end

    def disable(offer_id)
      remitano.net.patch("/offers/#{offer_id}/disable?coin_currency=#{coin}").execute
    end
  end
end
