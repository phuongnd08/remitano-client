require_relative "collection"

module Remitano
  class ActionConfirmations < Remitano::Collection
    def confirm!(id)
      Remitano::Net.post("/action_confirmations/#{id}/confirm", token: Remitano.authenticator_token).execute
    end
  end
end
