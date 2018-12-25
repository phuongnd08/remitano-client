require_relative "fiat_collection"

module Remitano
  class Client::FiatAccounts < Client::FiatCollection
    def me
      config.net.get("/fiat_accounts/me?currency=#{currency}").execute
    end
  end
end
