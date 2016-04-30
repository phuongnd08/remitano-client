module Remitano
  class RemiAccounts < Remitano::Collection
    def me
      Remitano::Net.get("/remi_accounts/me").execute
    end
  end
end
