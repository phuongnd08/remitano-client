require_relative "collection"

module Remitano
  class ActionConfirmations < Remitano::Collection
    attr_accessor :remitano

    def initialize(remitano: remitano)
      @remitano = remitano || Remitano.singleton
    end

    def confirm!(id)
      remitano.net.post("/action_confirmations/#{id}/confirm", token: remitano.authenticator_token).execute
    end

    def confirm_if_neccessary!(response)
      if response.is_action_confirmation && response.status != "confirmed"
        puts "Submitting token"
        confirm!(response.id)
      else
        response
      end
    end
  end
end
