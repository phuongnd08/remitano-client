require_relative "coin_collection"
module Remitano
  class Client::Offers < Client::CoinCollection
    def my_offers(side)
      config.net.get("/offers/my_offers?offer_type=#{side}&coin_currency=#{coin}").execute.offers
    end

    def update(offer_id, params)
      response = config.net.patch("/offers/#{offer_id}?coin_currency=#{coin}", params).execute
      config.action_confirmations.confirm_if_neccessary!(response)
    end

    def enable(offer_id)
      config.net.patch("/offers/#{offer_id}/enable?coin_currency=#{coin}").execute
    end

    def disable(offer_id)
      config.net.patch("/offers/#{offer_id}/disable?coin_currency=#{coin}").execute
    end
  end
end
