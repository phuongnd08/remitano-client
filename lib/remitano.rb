require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'active_model'
require 'rest_client'
require 'hmac-sha2'
require 'hashie'

Dir[File.expand_path("../remitano/**/*.rb", __FILE__)].each { |f| require f }

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

  def self.configure
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
