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
          "ref" => "MDR1248236781",
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

    context "valid params, currency is coin" do
      it "returns created charge" do
        client = Remitano::Client.default

        result = client.merchant_charges.create(
          coin_currency: "usdt",
          coin_amount: 10.99,
          cancelled_or_completed_callback_url: "http://sample.com/123/callback",
          description: "Example charge"
        )
        expect(result).to eq(
          "cancelled_or_completed_callback_url" => "http://sample.com/123/callback?remitano_id=146",
          "cancelled_or_completed_redirect_url" => nil,
          "coin_amount" => 10.99,
          "coin_currency" => "usdt",
          "created_at_timestamp" => 1627286204,
          "description" => "Example charge",
          "expired_at_timestamp" => 1627287104,
          "fiat_amount" => nil,
          "fiat_currency" => nil,
          "id" => 146,
          "payer_name" => nil,
          "payload" => nil,
          "ref" => "MDR1591502249",
          "remitano_payment_url" => "http://localhost:3200/payment_gateway/pay/MDR1591502249",
          "status" => "pending"
        )
      end
    end

    context "valid params, currency is fiat" do
      it "returns created charge" do
        client = Remitano::Client.default

        result = client.merchant_charges.create(
          fiat_currency: "AUD",
          fiat_amount: 10.99,
          cancelled_or_completed_callback_url: "http://sample.com/123/callback",
          description: "Example charge"
        )
        expect(result).to eq(
          "cancelled_or_completed_callback_url" => "http://sample.com/123/callback?remitano_id=144",
          "cancelled_or_completed_redirect_url" => nil,
          "coin_amount" => 7.33,
          "coin_currency" => "usdt",
          "created_at_timestamp" => 1627285893,
          "expired_at_timestamp" => 1627286793,
          "fiat_amount" => 10.99,
          "fiat_currency" => "AUD",
          "description" => "Example charge",
          "id" => 144,
          "payer_name" => nil,
          "payload" => nil,
          "ref" => "MDR0289485559",
          "remitano_payment_url" => "http://localhost:3200/payment_gateway/pay/MDR0289485559",
          "status" => "pending"
        )
      end
    end
  end

  describe "#list", :vcr do
    it "returns merchant charges" do
      client = Remitano::Client.default

      result = client.merchant_charges.list
      expect(result["merchant_charges"].count).to eq 25
      expect(result["merchant_charges"].pluck("status").uniq).to match_array(%w[pending cancelled])
      expect(result["meta"]["current_page"]).to eq 1
      expect(result["meta"]["per_page"]).to eq 25
      expect(result["meta"]["total_pages"]).to eq 3
    end

    context "filter by status" do
      it "returns status matched merchant charges" do
        client = Remitano::Client.default

        result = client.merchant_charges.list(status: "completed")
        expect(result["merchant_charges"].count).to eq 8
        expect(result["merchant_charges"].pluck("status").uniq).to eq(["completed"])
        expect(result["meta"]["current_page"]).to eq 1
        expect(result["meta"]["per_page"]).to eq 25
        expect(result["meta"]["total_pages"]).to eq 1
      end
    end

    context "page and per_page specified" do
      it "returns merchant charges in specified page" do
        client = Remitano::Client.default

        result = client.merchant_charges.list(status: "completed", page: 2, per_page: 3)
        expect(result["merchant_charges"].count).to eq 3
        expect(result["merchant_charges"].pluck("status").uniq).to eq(["completed"])
        expect(result["meta"]["current_page"]).to eq 2
        expect(result["meta"]["per_page"]).to eq 3
        expect(result["meta"]["total_pages"]).to eq 3
      end
    end
  end
end
