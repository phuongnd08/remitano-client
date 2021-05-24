require "spec_helper"

describe "Remitano::Client#merchant_charges" do
  describe "#get", :vcr do
    context "object not found" do
      it "raises error" do
        client = Remitano::Client.default
        expect do
          client.merchant_charges.get("invalid_id")
        end.to raise_error(Remitano::Client::Request::RequestError, "Error 404 {\"error\":\"Not found\"}")
      end
    end

    context "object exists" do
      it "returns charge data" do
        client = Remitano::Client.default
        result = client.merchant_charges.get(19)
        expect(result).to eq(
          "cancelled_or_completed_callback_url" => "http://sample.com/123/callback",
          "coin_amount" => 100.0,
          "coin_currency" => "usdt",
          "created_at_timestamp" => 1620093168,
          "id" => 19,
          "remitano_payment_url" => "localhost:3200/payment_gateway/pay/MDR1248236781",
          "status" => "completed"
        )
      end
    end
  end

  describe "#create", :vcr do
    context "invalid params" do
      it "raises error" do
        client = Remitano::Client.default
        expect do
          client.merchant_charges.create(
            coin_currency: "btc",
            coin_amount: 10.99,
            cancelled_or_completed_callback_url: "http://sample.com/123/callback"
          )
        end.to raise_error(Remitano::Client::Request::RequestError, "Error 400 {\"error\":\"coin_currency does not have a valid value\"}")
      end
    end

    context "valid params" do
      it "returns created charge" do
        client = Remitano::Client.default

        result = client.merchant_charges.create(
          coin_currency: "usdt",
          coin_amount: 10.99,
          cancelled_or_completed_callback_url: "http://sample.com/123/callback"
        )
        expect(result).to eq(
          "cancelled_or_completed_callback_url" => "http://sample.com/123/callback",
          "coin_amount" => 10.99,
          "coin_currency" => "usdt",
          "created_at_timestamp" => 1621497377,
          "id" => 22,
          "remitano_payment_url" => "localhost:3200/payment_gateway/pay/MDR5588788611",
          "status" => "pending"
        )
      end
    end
  end
end
