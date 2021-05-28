# frozen_string_literal: true

module Remitano
  class Client::MerchantWithdrawals
    attr_reader :config

    def initialize(config:)
      @config = config
    end

    def get(id)
      config.net.get("/merchant/merchant_withdrawals/#{id}").execute
    end

    def create(
      merchant_withdrawal_ref:, coin_currency:, coin_amount:, receiver_pay_fee:, cancelled_or_completed_callback_url:,
      coin_address: nil, destination_tag: nil, remitano_username: nil, remitano_phone_number: nil
    )
      withdrawal = config.net.post(
        "/merchant/merchant_withdrawals",
        merchant_withdrawal_ref: merchant_withdrawal_ref,
        coin_currency: coin_currency,
        coin_amount: coin_amount,
        receiver_pay_fee: receiver_pay_fee,
        cancelled_or_completed_callback_url: cancelled_or_completed_callback_url,
        coin_address: coin_address,
        destination_tag: destination_tag,
        remitano_username: remitano_username,
        remitano_phone_number: remitano_phone_number
      ).execute
      if (action_confirmation_id = withdrawal["action_confirmation_id"]).present?
        config.action_confirmations.confirm_by_hotp!(action_confirmation_id, withdrawal["otp_counter"])
      end

      withdrawal
    end
  end
end
