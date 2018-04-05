require 'spec_helper'

describe Remitano::Public::CoinRates do
  describe :active, vcr: {cassette_name: 'remitano/rates'} do
    subject { Remitano::Public::CoinRates.fetch }
    it "contains btc rates" do
      subject["bid"].should eq 654.34
    end
  end
end
