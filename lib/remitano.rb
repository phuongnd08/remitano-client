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

  # API Key
  mattr_accessor :key

  # Remitano secret
  mattr_accessor :secret

  mattr_accessor :authenticator_secret

  def self.offers
    @offers ||= Remitano::Offers
  end

  def self.trades
    @trades ||= Remitano::Trades
  end

  def self.coin_accounts
    @coin_accounts ||= Remitano::CoinAccounts
  end

  def self.rates
    @rates ||= Remitano::Public::CoinRates.new
  end

  def self.coin_withdrawals
    @coin_withdrawals ||= Remitano::CoinWithdrawals
  end

  def self.action_confirmations
    @action_confirmations ||= Remitano::ActionConfirmations.new
  end

  def self.authenticator_token
    ROTP::TOTP.new(authenticator_secret).now
  end

  def self.configure
    yield self
  end
end
