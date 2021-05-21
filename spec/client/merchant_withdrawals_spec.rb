require "spec_helper"

describe "Remitano::Client#merchant_withdrawals" do
  describe "#get", :vcr do
    context "object not found" do
      it "raises error" do
        client = Remitano::Client.default
        expect do
          client.merchant_withdrawals.get("invalid_id")
        end.to raise_error(Remitano::Client::Request::RequestError, "Error 404 {\"error\":\"Not found\"}")
      end
    end

    context "object exists" do
      it "returns withdrawal data" do
        client = Remitano::Client.default
        result = client.merchant_withdrawals.get(1)
        expect(result).to eq(
          "action_confirmation_id" => nil,
          "cancelled_or_completed_callback_url" => "http://dummy.com/111",
          "coin_address" => "3BDS42pbFgxDn9uMSCBiWE5BcWFBVPPCAA",
          "coin_amount" => 100.0,
          "coin_currency" => "usdt",
          "coin_fee" => 0.0,
          "created_at_timestamp" => 1621401962,
          "destination_tag" => nil,
          "id" => 1,
          "merchant_withdrawal_ref" => "mwr2",
          "otp_counter" => nil,
          "receiver_pay_fee" => nil,
          "remitano_phone_number" => nil,
          "remitano_username" => nil,
          "status" => "cancelled"
        )
      end
    end
  end

  describe "#create", :vcr do
    context "invalid params" do
      it "raises error" do
        client = Remitano::Client.default
        expect do
          client.merchant_withdrawals.create(
            merchant_withdrawal_ref: "akh9r1h29e1",
            coin_currency: "xrp",
            coin_amount: 10.99,
            receiver_pay_fee: true,
            cancelled_or_completed_callback_url: "http://sample.com/123/callback",
            coin_address: "rLpumSZQNJ6Cve7hfQcdkG9rJbJhkSV8AD0",
            destination_tag: 1710676231
          )
        end.to raise_error(
          Remitano::Client::Request::RequestError,
          "Error 422 {\"error\":\"Merchant withdrawal ref has already been taken, Coin address is invalid\"}"
        )
      end
    end

    context "valid params" do
      it "auto confirms withdrawal with htop and returns created withdrawal" do
        client = Remitano::Client.default
        expect(client.action_confirmations).to receive(:confirm_by_hotp!).and_call_original
        create_result = client.merchant_withdrawals.create(
          merchant_withdrawal_ref: "akh9r1h29e16",
          coin_currency: "xrp",
          coin_amount: 10.99,
          receiver_pay_fee: true,
          cancelled_or_completed_callback_url: "http://sample.com/123/callback",
          coin_address: "rLpumSZQNJ6Cve7hfQcdkG9rJbJhkSV8AD",
          destination_tag: 1710676231
        )
        expect(create_result).to eq(
          "action_confirmation_id" => 32,
          "cancelled_or_completed_callback_url" => "http://sample.com/123/callback",
          "coin_address" => "rLpumSZQNJ6Cve7hfQcdkG9rJbJhkSV8AD",
          "coin_amount" => 10.99,
          "coin_currency" => "xrp",
          "coin_fee" => 0.00002,
          "created_at_timestamp" => 1621786247,
          "destination_tag" => 1710676231,
          "id" => 16,
          "merchant_withdrawal_ref" => "akh9r1h29e16",
          "otp_counter" => 32,
          "receiver_pay_fee" => true,
          "remitano_phone_number" => nil,
          "remitano_username" => nil,
          "status" => "pending"
        )
        get_result = client.merchant_withdrawals.get(create_result["id"])
        expect(get_result).to eq(
          "action_confirmation_id" => nil,
          "cancelled_or_completed_callback_url" => "http://sample.com/123/callback",
          "coin_address" => "rLpumSZQNJ6Cve7hfQcdkG9rJbJhkSV8AD",
          "coin_amount" => 10.99,
          "coin_currency" => "xrp",
          "coin_fee" => 0.00002,
          "created_at_timestamp" => 1621786247,
          "destination_tag" => 1710676231,
          "id" => 16,
          "merchant_withdrawal_ref" => "akh9r1h29e16",
          "otp_counter" => nil,
          "receiver_pay_fee" => true,
          "remitano_phone_number" => nil,
          "remitano_username" => nil,
          "status" => "processing"
        )
      end
    end
  end
end
