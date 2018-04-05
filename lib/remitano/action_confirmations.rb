require_relative "collection"

module Remitano
  class ActionConfirmations < Remitano::Collection
    def self.confirm!(id)
      Remitano::Net.post("/action_confirmations/#{id}/confirm", token: Remitano.authenticator_token).execute
    end

    def self.confirm_if_neccessary!(response)
      if response.is_action_confirmation && response.status != "confirmed"
        puts "Submitting token"
        confirm!(response.id)
      else
        response
      end
    end
  end
end
