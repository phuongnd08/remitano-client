require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'rest_client'
require 'hmac-sha2'
require 'hashie'
require 'rotp'

Dir[File.expand_path("../remitano/**/*.rb", __FILE__)].each { |f| require f }

String.send(:include, ActiveSupport::Inflector)

module Remitano
  class AuthenticatorNotConfigured < StandardError; end

  def self.singleton
    @config ||= Remitano::Config.new
  end

  class Config
    # API Key
    attr_accessor :key

    # Remitano secret
    attr_accessor :secret

    attr_accessor :authenticator_secret

    attr_accessor :verbose

    def authenticator_token
      ROTP::TOTP.new(authenticator_secret).now
    end

    def net
      @net ||= Remitano::Net.new(remitano: self)
    end

    def action_confirmations
      @action_confirmations ||= Remitano::ActionConfirmations.new(remitano: self)
    end

    def coin_accounts(coin)
      @coin_accounts ||= {}
      @coin_accounts[coin] ||= Remitano::CoinAccounts.new(coin, remitano: self)
    end

    def configure
      yield self
    end
  end
end
