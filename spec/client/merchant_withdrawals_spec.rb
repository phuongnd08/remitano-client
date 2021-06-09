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
          "ref" => "MWR1774298352",
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
          "Error 422 {\"error\":\"Merchant withdrawal ref has already been taken, "\
          "Coin amount exceeds available balance, Coin address is invalid\"}"
        )
      end
    end

    context "valid params" do
      it "auto confirms withdrawal with htop and returns created withdrawal" do
        client = Remitano::Client.default
        expect(client.action_confirmations).to receive(:confirm_by_hotp!).and_call_original
        create_result = client.merchant_withdrawals.create(
          merchant_withdrawal_ref: "akh9r1h29e19",
          coin_currency: "xrp",
          coin_amount: 10.99,
          receiver_pay_fee: true,
          cancelled_or_completed_callback_url: "http://sample.com/123/callback",
          coin_address: "rLpumSZQNJ6Cve7hfQcdkG9rJbJhkSV8AD",
          destination_tag: 1710676231
        )
        expect(create_result).to eq(
          "action_confirmation_id" => 34,
          "cancelled_or_completed_callback_url" => "http://sample.com/123/callback",
          "coin_address" => "rLpumSZQNJ6Cve7hfQcdkG9rJbJhkSV8AD",
          "coin_amount" => 10.99,
          "coin_currency" => "xrp",
          "coin_fee" => 0.00002,
          "created_at_timestamp" => 1622185568,
          "destination_tag" => 1710676231,
          "id" => 18,
          "merchant_withdrawal_ref" => "akh9r1h29e19",
          "otp_counter" => 34,
          "receiver_pay_fee" => true,
          "ref" => "MWR1926186585",
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
          "created_at_timestamp" => 1622185568,
          "destination_tag" => 1710676231,
          "id" => 18,
          "merchant_withdrawal_ref" => "akh9r1h29e19",
          "otp_counter" => nil,
          "receiver_pay_fee" => true,
          "ref" => "MWR1926186585",
          "remitano_phone_number" => nil,
          "remitano_username" => nil,
          "status" => "processing"
        )
      end
    end
  end

  describe "#list", :vcr do
    it "returns merchant withdrawals" do
      client = Remitano::Client.default

      result = client.merchant_withdrawals.list
      expect(result["merchant_withdrawals"].count).to eq 18
      expect(result["merchant_withdrawals"].pluck("status").uniq).to match_array(%w[pending processing cancelled])
      expect(result["meta"]["current_page"]).to eq 1
      expect(result["meta"]["per_page"]).to eq 25
      expect(result["meta"]["total_pages"]).to eq 1
    end

    context "filter by status" do
      it "returns status matched merchant withdrawals" do
        client = Remitano::Client.default

        result = client.merchant_withdrawals.list(status: "cancelled")
        expect(result["merchant_withdrawals"].count).to eq 9
        expect(result["merchant_withdrawals"].pluck("status").uniq).to eq(["cancelled"])
        expect(result["meta"]["current_page"]).to eq 1
        expect(result["meta"]["per_page"]).to eq 25
        expect(result["meta"]["total_pages"]).to eq 1
      end
    end

    context "page and per_page specified" do
      it "returns merchant withdrawals in specified page" do
        client = Remitano::Client.default

        result = client.merchant_withdrawals.list(status: "cancelled", page: 2, per_page: 5)
        expect(result["merchant_withdrawals"].count).to eq 4
        expect(result["merchant_withdrawals"].pluck("status").uniq).to eq(["cancelled"])
        expect(result["meta"]["current_page"]).to eq 2
        expect(result["meta"]["per_page"]).to eq 5
        expect(result["meta"]["total_pages"]).to eq 2
      end
    end
  end
end
