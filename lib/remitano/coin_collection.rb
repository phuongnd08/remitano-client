require_relative "collection"

module Remitano
  class CoinCollection < Collection
    COIN_CURRENCIES = %w(btc eth bch usdt)

    attr_reader :remitano, :coin

    def initialize(coin, remitano: nil)
      @remitano = remitano || Remitano.singleton
      @coin = coin
      super()
    end

    class << self
      def of_coin(coin, remitano: nil)
        new(coin, remitano: remitano)
      end

      COIN_CURRENCIES.each do |coin|
        define_method coin.to_sym do |*args|
          new(coin, args.last)
        end
      end
    end
  end
end
