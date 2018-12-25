require_relative "collection"

module Remitano
  class Client::ActionConfirmations < Client::Collection
    attr_accessor :config

    def initialize(config:)
      @config = config
    end

    def confirm!(id)
      config.net.post("/action_confirmations/#{id}/confirm", token: config.authenticator_token).execute
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
