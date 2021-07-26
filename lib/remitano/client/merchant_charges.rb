# frozen_string_literal: true

module Remitano
  class Client::MerchantCharges
    attr_reader :config

    def initialize(config:)
      @config = config
    end

    def get(id)
      config.net.get("/merchant/merchant_charges/#{id}").execute
    end

    def create(
      coin_currency: nil, coin_amount: nil,
      fiat_currency: nil, fiat_amount: nil,
      cancelled_or_completed_callback_url: nil, description: nil
    )
      params = {
        coin_currency: coin_currency,
        coin_amount: coin_amount,
        fiat_currency: fiat_currency,
        fiat_amount: fiat_amount,
        cancelled_or_completed_callback_url: cancelled_or_completed_callback_url,
        description: description
      }
      params.reject! { |_k, v| v.nil? }
      config.net.post(
        "/merchant/merchant_charges",
        params
      ).execute
    end

    def list(status: nil, page: nil, per_page: nil)
      params = {
        status: status,
        page: page,
        per_page: per_page
      }
      params.reject! { |_k, v| v.nil? }
      config.net.get(
        "/merchant/merchant_charges",
        params
      ).execute
    end
  end
end
