require_relative "coin_collection"

module Remitano
  class Client::CoinAccounts < Client::CoinCollection
    def me
      config.net.get("/coin_accounts/me?coin_currency=#{coin}").execute
    end
  end
end
