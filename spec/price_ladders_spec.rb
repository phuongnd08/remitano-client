require 'spec_helper'

describe "Remitano.price_ladders",  vcr: {cassette_name: 'remitano/price_ladders'} do
  it "returns buy and sell ladders" do
    price_ladders = Remitano.price_ladders
    expect(price_ladders.buy.length).to eq(5)
    expect(price_ladders.sell.length).to eq(5)
  end
end
