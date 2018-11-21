require_relative "collection"

module Remitano
  class CoinCollection < Collection
    attr_reader :config, :coin

    def initialize(coin, config:)
      @coin = coin
      super(config: config)
    end

    class << self
      def of_coin(coin, config:)
        new(coin, config: config)
      end
    end
  end
end
