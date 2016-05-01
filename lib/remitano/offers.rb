require_relative "collection"
module Remitano
  class Offers < Remitano::Collection
    def my_offers(side)
      Remitano::Net.get("/offers/my_offers?offer_type=#{side}").execute.offers
    end

    def update(offer_id, params)
      Remitano::Net.patch("/offers/#{offer_id}", params).execute
    end

    def enable(offer_id)
      Remitano::Net.patch("/offers/#{offer_id}/enable").execute
    end

    def disable(offer_id)
      Remitano::Net.patch("/offers/#{offer_id}/disable").execute
    end
  end
end
