require_relative "collection"

module Remitano
  class ActionConfirmations < Remitano::Collection
    def confirm!(id, token)
      Remitano::Net.post("/action_confirmations/#{id}/confirm", token: token).execute
    end
  end
end
