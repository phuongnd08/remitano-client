require 'spec_helper'

class Remitano::Coin < Remitano::Model;end
class Remitano::Coins < Remitano::Collection;end

describe Remitano::Coins do
  subject { Remitano::Coins.new }
  its(:name) { should eq 'coin' }
  its(:module) { should eq "remitano/coin" }
  its(:model) { should be Remitano::Coin }
  its(:path) { should eq "/api/coins" }
end
