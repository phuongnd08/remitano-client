require_relative "collection"

module Remitano
  class CoinCollection < Collection
    COIN_CURRENCIES = %w(btc eth bch usdt)

    attr_reader :coin

    def initialize(coin)
      @coin = coin
      super()
    end

    class << self
      def of_coin(coin)
        new(coin)
      end

      COIN_CURRENCIES.each do |coin|
        define_method coin.to_sym do
          new(coin)
        end
      end
    end
  end
end
