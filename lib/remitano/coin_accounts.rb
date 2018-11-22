require_relative "coin_collection"

module Remitano
  class CoinAccounts < Remitano::CoinCollection
    def me
      config.net.get("/coin_accounts/me?coin_currency=#{coin}").execute
    end
  end
end
