# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'rest_client'
require 'hmac-sha2'
require 'hashie'
require 'rotp'

String.send(:include, ActiveSupport::Inflector)

module Remitano
  class Client
    class << self
      attr_accessor :default_key, :default_secret, :default_authenticator_secret, :default_verbose
      def default
        @default ||= new(key: default_key, secret: default_secret, authenticator_secret: default_authenticator_secret, verbose: default_verbose)
      end
    end

    attr_accessor :key, :secret, :authenticator_secret, :verbose

    def initialize(key:, secret:, authenticator_secret: nil, verbose: false)
      self.key = key
      self.secret = secret
      self.authenticator_secret = authenticator_secret
      self.verbose = verbose
    end

    def authenticator_token
      ROTP::TOTP.new(authenticator_secret).now
    end

    def hotp(otp_counter)
      ROTP::HOTP.new(authenticator_secret).at(otp_counter)
    end

    def net
      @net ||= Remitano::Client::Net.new(config: self)
    end

    def action_confirmations
      @action_confirmations ||= ActionConfirmations.new(config: self)
    end

    def coin_accounts(coin)
      @coin_accounts ||= {}
      @coin_accounts[coin] ||= CoinAccounts.new(coin, config: self)
    end

    def fiat_accounts(currency)
      @fiat_accounts ||= {}
      @fiat_accounts[currency] ||= FiatAccounts.new(currency, config: self)
    end

    def offers(coin)
      @offers ||= {}
      @offers[coin] ||= Offers.new(coin, config: self)
    end

    def trades(coin)
      @trades ||= {}
      @trades[coin] ||= Trades.new(coin, config: self)
    end

    def coin_withdrawals(coin)
      @coin_withdrawals ||= CoinWithdrawals.new(coin, config: self)
    end

    def orders
      @orders ||= Orders.new(config: self)
    end

    def rates
      @rates ||= Rates.new
    end

    def public_offers(coin)
      @public_offers ||= {}
      @public_offers[coin] ||= PublicOffers.new(coin)
    end

    def price_ladders
      @price_ladders ||= PriceLadders.new
    end

    def merchant_charges
      @merchant_charges ||= MerchantCharges.new(config: self)
    end

    def merchant_withdrawals
      @merchant_withdrawals ||= MerchantWithdrawals.new(config: self)
    end
  end
end

Dir[File.expand_path("../client/**/*.rb", __FILE__)].each { |f| require f }
