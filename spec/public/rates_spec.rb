require 'spec_helper'

describe Remitano::Client::Rates do
  describe :active, vcr: {cassette_name: 'remitano/rates'} do
    subject { Remitano::Client.default.rates.ads }
    it "contains btc rates" do
      subject["bid"].should eq 654.34
    end
  end
end
