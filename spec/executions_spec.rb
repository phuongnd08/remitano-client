require 'spec_helper'

describe Remitano.executions do
  describe :all, vcr: {cassette_name: 'remitano/executions/all'} do
    subject { Remitano.executions.all(order_id: 1) }
    it { should be_kind_of Array }
    describe "first execution" do
      subject { Remitano.executions.all(order_id: 1).first }
      its(:price) { should be_present }
      its(:btc_amount) { should be_present }
      its(:self_matching) { should be_true }
    end
  end
end
