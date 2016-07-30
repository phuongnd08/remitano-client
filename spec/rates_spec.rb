require 'spec_helper'

describe Remitano::Public::BtcRates do
  describe :active, vcr: {cassette_name: 'remitano/rates'} do
    subject { Remitano.rates.fetch }
    it "contains btc rates" do
      subject["bid"].should eq 654.34
    end
  end
end
