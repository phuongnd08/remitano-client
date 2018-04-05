require 'spec_helper'

describe Remitano::Trades do
  describe :active, vcr: {cassette_name: 'remitano/trades/active'} do
    subject { Remitano::Trades.btc.active("sell").trades }
    its(:length) { should == 1 }
    describe "first trade" do
      subject { Remitano::Trades.btc.active("sell").trades.first }
      its(:price) { should == 22800 }
      its(:seller_sending_amount) { should == 275 }
      its(:buyer_username) { should be_present }
      its(:seller_username) { should be_present }
      its(:other_amount) { should be_present }
      its(:created_at) { should be_present }
      its(:status) { should == "unpaid" }
    end
  end

  describe :closed, vcr: {cassette_name: 'remitano/trades/closed'} do
    subject { Remitano::Trades.btc.closed("sell").trades }
    its(:length) { should == 1 }
    describe "first trade" do
      subject { Remitano::Trades.btc.closed("sell").trades.first }
      its(:price) { should == 22800}
      its(:buyer_receiving_amount) { should == 275 }
      its(:buyer_username) { should be_present }
      its(:seller_username) { should be_present }
      its(:created_at) { should be_present }
      its(:status) { should == "cancelled" }
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
