require 'spec_helper'

describe Remitano::Trades do
  describe :active, vcr: {cassette_name: 'remitano/trades/active'} do
    describe "first trade" do
      subject { Remitano::Trades.btc.active("sell").trades.first }
      it "should have correct values" do
        subject.price.should == 22800
        subject.seller_sending_amount.should == 275
        subject.buyer_username.should be_present
        subject.seller_username.should be_present
        subject.created_at.should be_present
        subject.status.should == "unpaid"
      end
    end
  end

  describe :closed, vcr: {cassette_name: 'remitano/trades/closed'} do
    describe "first trade" do
      subject { Remitano::Trades.btc.closed("sell").trades.first }
      it "should have correct value" do
        subject.price.should == 22800
        subject.seller_sending_amount.should == 275
        subject.buyer_username.should be_present
        subject.seller_username.should be_present
        subject.created_at.should be_present
        subject.status.should == "cancelled"
      end
    end
  end

  describe :release, vcr: {cassette_name: 'remitano/trades/release'} do
    it "release the trade" do
      Remitano::Trades.btc.release("2T61603008")
      trade = Remitano::Trades.btc.get("2T61603008")
      trade[:status].should == "released"
    end
  end
end
