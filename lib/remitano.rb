require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'active_model'
require 'rest_client'
require 'hmac-sha2'
require 'hashie'

require 'remitano/net'
require 'remitano/helper'

require 'remitano/orders'
require 'remitano/transactions'
require 'remitano/collection'

String.send(:include, ActiveSupport::Inflector)

module Remitano
  # API Key
  mattr_accessor :key

  # Remitano secret
  mattr_accessor :secret

  # Currency
  mattr_accessor :currency
  @@currency = :usd

  def self.orders
    self.sanity_check!

    @@orders ||= Remitano::Orders.new
  end

  def self.user_transactions
    self.sanity_check!

    @@transactions ||= Remitano::UserTransactions.new
  end

  def self.transactions
    return Remitano::Transactions.from_api
  end

  def self.balance
    self.sanity_check!

    JSON.parse Remitano::Net.post('/balance').to_str
  end

  def self.withdraw_bitcoins(options = {})
    self.sanity_check!
    if options[:amount].nil? || options[:address].nil?
      raise MissingConfigExeception.new("Required parameters not supplied, :amount, :address")
    end
    response_body = Remitano::Net.post('/bitcoin_withdrawal',options).body_str
    if response_body != 'true'
      return JSON.parse response_body
    else
      return response_body
    end
  end
  def self.bitcoin_deposit_address
    # returns the deposit address
    self.sanity_check!
    return Remitano::Net.post('/bitcoin_deposit_address').body_str
  end

  def self.unconfirmed_user_deposits
    self.sanity_check!
    return JSON.parse Remitano::Net::post("/unconfirmed_btc").body_str
  end

  def self.ticker
    return Remitano::Ticker.from_api
  end

  def self.order_book
    return JSON.parse Remitano::Net.get('/order_book').to_str
  end

  def self.setup
    yield self
  end

  def self.configured?
    self.key && self.secret
  end

  def self.sanity_check!
    unless configured?
      raise MissingConfigExeception.new("Remitano Gem not properly configured")
    end
  end

  class MissingConfigExeception<Exception;end;
end
