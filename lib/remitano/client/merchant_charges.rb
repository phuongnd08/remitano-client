# frozen_string_literal: true

module Remitano
  class Client::MerchantCharges
    attr_reader :config

    def initialize(config:)
      @config = config
    end

    def get(id)
      config.net.get("/merchant/merchant_deposit_requests/#{id}").execute
    end

    def create(coin_currency:, coin_amount:, cancelled_or_completed_callback_url:)
      config.net.post(
        "/merchant/merchant_deposit_requests",
        coin_currency: coin_currency,
        coin_amount: coin_amount,
        cancelled_or_completed_callback_url: cancelled_or_completed_callback_url
      ).execute
    end
  end
end
