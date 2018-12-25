require 'spec_helper'

describe "Remitano::Client#fiat_accounts" do
  describe :me, vcr: {cassette_name: 'remitano/fiat_accounts/me'} do
    subject { Remitano::Client.default.fiat_accounts("zar") }
    it "returns my zar fiat account" do
      result = subject.me
      expect(result.balance).to eq(0)
    end
  end
end
