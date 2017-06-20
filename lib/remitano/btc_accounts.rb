require_relative "collection"

module Remitano
  class BtcAccounts < Remitano::Collection
    def me
      Remitano::Net.get("/coin_accounts/me").execute
    end
  end
end
