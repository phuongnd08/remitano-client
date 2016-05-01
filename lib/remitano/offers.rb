require_relative "collection"
module Remitano
  class Offers < Remitano::Collection
    def my_offers(side)
      Remitano::Net.get("/offers?offer_type=#{side}").execute.offers
    end

    def update(offer_id, params)
      Remitano::Net.patch("/offers/#{offer_id}", params).execute
    end
  end
end
