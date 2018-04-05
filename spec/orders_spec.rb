require 'spec_helper'

describe Remitano::Orders do
  describe :open, vcr: {cassette_name: 'remitano/orders/open'} do
    subject { Remitano::Orders.open("btcusdt", page: 1) }
    it "returns list of orders" do
      expect(subject["orders"].count).to eq 4
      expect(subject["orders"].first["status"]).to eq "open"
      expect(subject["orders"].first["side"]).to eq "sell"
    end
  end

  describe :create, vcr: {cassette_name: 'remitano/orders/create'} do
    it "create the order" do
      order = Remitano::Orders.create(
        pair: "btcusdt", side: "sell",
        price: "10000", amount: 0.001
      )
      expect(order["status"]).to eq "open"
    end
  end

  describe :cancel, vcr: {cassette_name: 'remitano/orders/cancel'} do
    it "cancel the order" do
      order = Remitano::Orders.cancel(27)
      expect(order["status"]).to eq "cancelled"
    end
  end
end
