require 'spec_helper'

describe Remitano::UserTransactions do
  before { setup_remitano }

  describe :all, vcr: {cassette_name: 'remitano/user_transactions/all'} do
    subject { Remitano.user_transactions.all }
    its(:count) { should == 47 }
    context "first transaction" do
      subject { Remitano.user_transactions.all.first }
      it { should be_kind_of(Remitano::UserTransaction) }
      its(:btc) { should == "-3.00781124" }
      its(:btc_usd) { should == "0.00" }
      its(:datetime) { should == "2013-09-26 13:46:59" }
      its(:fee) { should == "0.00" }
      its(:order_id) { should be_nil }
      its(:type) { should == 1 }
      its(:usd) { should == "0.00" }
    end
  end

end

describe Remitano::Transactions do
  before { setup_remitano }

  describe :all, vcr:{cassette_name: 'remitano/transactions'} do
    subject { Remitano.transactions }
    it { should be_kind_of Array }
  end

end
