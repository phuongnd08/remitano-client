require 'spec_helper'

describe Remitano::Public::PriceLadders do
  describe :active, vcr: {cassette_name: 'remitano/price_ladders/sell'} do
    subject { Remitano::Public::PriceLadders.fetch("btcusdt") }
    it "contains buy and sell ladders" do
      expect(subject["buy"].length).to eq 4
      expect(subject["sell"].length).to eq 4
    end
  end
end
