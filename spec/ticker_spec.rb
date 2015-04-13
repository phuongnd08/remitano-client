require 'spec_helper'

describe "Remitano.price_ladders",  vcr: {cassette_name: 'remitano/ticker'} do
  it "returns bid ask and last price" do
    ticker = Remitano.ticker
    expect(ticker.market_bid).to be_present
    expect(ticker.market_ask).to be_present
    expect(ticker.last_price).to be_present
  end
end
