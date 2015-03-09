require 'spec_helper'

describe Remitano::Orders do
  before { setup_remitano }

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

  describe :sell do
    context "no permission found", vcr: {cassette_name: 'remitano/orders/sell/failure'} do
      subject { Remitano.orders.sell(:amount => 1, :price => 1000) }
      it { should be_kind_of Remitano::Order }
      its(:error) { should == "No permission found" }
    end
    # context "bitcoins available", vcr: {cassette_name: 'remitano/orders/sell/success'} do
    #   subject { Remitano.orders.sell(:amount => 1, :price => 1000) }
    #   xit { should be_kind_of Remitano::Order }
    #   its(:error) { should be_nil }
    # end
  end

  describe :buy, vcr: {cassette_name: 'remitano/orders/buy'} do
    subject { Remitano.orders.buy(:amount => 1, :price => 1.01) }
    it { should be_kind_of Remitano::Order }
    its(:price) { should == "1.01" }
    its(:amount) { should == "1" }
    its(:type) { should == 0 }
    its(:datetime) { should == "2013-09-26 23:26:56.849475" }
    its(:error) { should be_nil }
  end
end
