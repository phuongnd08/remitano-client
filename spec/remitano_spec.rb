require 'spec_helper'

describe Remitano do
  describe :sanity_check! do
    context 'not properly configured' do
      before do
        Remitano.configure do |config|
          config.key = nil
          config.secret = nil
        end
      end
      it { -> { Remitano.sanity_check! }.should raise_error }
    end

    context 'properly configured' do
      it { -> { Remitano.sanity_check! }.should_not raise_error }
    end
  end

  describe :orders do
    it { should respond_to :orders }
  end
end
