require 'spec_helper'

describe Remitano do

  describe :sanity_check! do
    context 'not properly configured' do
      it { -> { Remitano.sanity_check! }.should raise_error }
    end
    context 'properly configured' do
      before {
        Remitano.setup do |config|
          config.key = 'test'
          config.secret = 'test'
          config.client_id = 'test'
        end
      }
      it { -> { Remitano.sanity_check! }.should_not raise_error }
    end
  end

  describe :orders do
    it { should respond_to :orders }
  end

  describe :ticket, vcr: {cassette_name: 'remitano/ticker'} do
    subject { Remitano.ticker }
    it { should be_kind_of Remitano::Ticker }
    its(:high) { should == "124.90" }
    its(:last) { should == "124.55" }
    its(:timestamp) { should == "1380237724" }
    its(:bid) { should == "124.55" }
    its(:volume) { should == "7766.46908740" }
    its(:low) { should == "123.00" }
    its(:ask) { should == "124.56" }
  end

  describe :balance, vcr: {cassette_name: 'remitano/balance'} do
    context "configured" do
      subject { Remitano.balance }
      before { setup_remitano }
      it { should == {"btc_reserved"=>"0", "fee"=>"0.4000", "btc_available"=>"0", "usd_reserved"=>"1.02", "btc_balance"=>"0", "usd_balance"=>"6953.07", "usd_available"=>"6952.05"} }
    end
    context "not configured" do
      it { expect { Remitano.balance }.to raise_exception(Remitano::MissingConfigExeception, "Remitano Gem not properly configured") }
    end
  end

  describe :order_book, vcr: {cassette_name: 'remitano/order_book'} do
    let(:order_book) { Remitano.order_book }
    subject { order_book }
    it { should be_kind_of Hash }
    it { should have_key("asks") }
    it { should have_key("bids") }
    it { order_book["asks"].should be_kind_of Array }
    it { order_book["bids"].should be_kind_of Array }
  end

  describe :withdraw_bitcoins do
    before {setup_remitano}
    context "Failed to supply correct arguments", vcr: {cassette_name: 'remitano/withdraw_bitcoins/wrong_arguments'} do
      subject { Remitano.withdraw_bitcoins(amount:100) }
      #its(:error) { should == "Required parameters not supplied, :amount, :address" }
    end
    context "Failed to withdraw bitcoins", vcr: {cassette_name: 'remitano/withdraw_bitcoins/failure'} do
      subject { Remitano.withdraw_bitcoins(:amount=>100, :address=>"17Vr8d1yWrA226QNYZLDwaG4vDMUEaT9t5") }
      it {should == {"error"=>{"amount"=>["You have only 0 BTC available. Check your account balance for details."]}}}
      #its(:error) { should == "Required parameters not supplied, :amount, :address" }
    end
    # context "succesfully withdrew bitcoins", vcr: {cassette_name: 'remitano/withdraw_bitcoins/success'} do
    #   subject { Remitano.withdraw_bitcoins(:amount=>0.04976353, :address=>"17Vr8d1yWrA226QNYZLDwaG4vDMUEaT9t5") }
    #   it {should =='true'}
    #   #its(:error) { should == "Required parameters not supplied, :amount, :address" }
    # end
  end
  describe :unconfirmed_user_deposits, vcr: {cassette_name: 'remitano/unconfirmed_user_deposits'}  do
    before {setup_remitano}
    subject { Remitano.unconfirmed_user_deposits }
    it {should be_kind_of Array}

  end
  #
  # Works but for privacy reasons I dont want to include the cassette
  #
  # describe :bitcoin_deposit_address, vcr: {cassette_name: 'remitano/bitcoin_deposit_address'} do
  #   before {setup_remitano}
  #   subject {Remitano.bitcoin_deposit_address}
  #   #it {should match /^[13][a-zA-Z0-9]{26,33}$/} TODO:fix this spec
  # end
end
