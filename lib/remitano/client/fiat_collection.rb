require_relative "collection"

module Remitano
  class Client::FiatCollection < Client::Collection
    attr_reader :config, :currency

    def initialize(currency, config:)
      @currency = currency
      super(config: config)
    end

    class << self
      def of_currency(currency, config:)
        new(currency, config: config)
      end
    end
  end
end
