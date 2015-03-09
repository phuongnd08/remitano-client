require 'spec_helper'

describe Remitano::Orders do
  before { configure_remitano }

  describe :all, vcr: {cassette_name: 'remitano/orders/all'} do
    subject { Remitano.orders.all }
    it { should be_kind_of Array }
    describe "first order" do
      subject { Remitano.orders.all.first }
      its(:price) { should == "372.04" }
      its(:quantity) { should == "1.5" }
      its(:order_type) { should == "limit" }
      its(:created_at) { should == "2015-03-09T09:11:37.060Z" }
    end
  end

  describe :sell, vcr: {cassette_name: 'remitano/orders/sell'} do
    subject { Remitano.orders.sell(order_type: "limit", :quantity => 1.2, :price => 350) }
    its(:price) { should == "350.0" }
    its(:side) { should == "sell" }
    its(:quantity) { should == "1.2" }
    its(:order_type) { should == "limit" }
  end

  describe :buy, vcr: {cassette_name: 'remitano/orders/buy'} do
    subject { Remitano.orders.buy(order_type: "limit", :quantity => 1.5, :price => 349) }
    its(:price) { should == "349.0" }
    its(:side) { should == "buy" }
    its(:quantity) { should == "1.5" }
    its(:order_type) { should == "limit" }
  end

  describe :cancel, vcr: {cassette_name: 'remitano/orders/cancel'} do
    subject { Remitano.orders.cancel(4) }
    its(:price) { should == "349.0" }
    its(:side) { should == "buy" }
    its(:status) { should == "cancelled" }
  end
end
