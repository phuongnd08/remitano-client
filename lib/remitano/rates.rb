require_relative "collection"
module Remitano
  class Rates
    def fetch
      Remitano::Net.get("/btc_rates/fetch").execute
    end
  end
end
