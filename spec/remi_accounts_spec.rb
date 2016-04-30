require 'spec_helper'

describe Remitano::RemiAccounts do
  describe :me, vcr: {cassette_name: 'remitano/accounts/me'} do
    subject { Remitano.remi_accounts.me }
    describe "first trade" do
      its(:balance) { should == 4615 }
    end
  end
end
