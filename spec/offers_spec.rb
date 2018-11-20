require 'spec_helper'

describe Remitano::Offers do
  describe :my_offers, vcr: {cassette_name: 'remitano/my_offers/sell'} do
    subject { Remitano::Offers.of_coin("btc").my_offers("sell") }
    it "should have 1 item" do
      subject.length.should == 1
    end
  end

  describe :update, vcr: {cassette_name: 'remitano/offers/update'} do
    it "change the offer" do
      Remitano::Offers.of_coin("btc").update(2, price: 21800)
      offer = Remitano::Offers.btc(remitano: Remitano.singleton).my_offers("sell").first
      offer[:price].should == 21800
    end
  end
end
