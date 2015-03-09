RSpec.configure do |config|
  config.before(:each) do
    # The famous singleton problem
    Remitano.setup do |config|
      config.key = nil
      config.secret = nil
    end
  end
end

def setup_remitano
  Remitano.setup do |config|
    raise "REMITANO_KEY is not set" unless ENV["REMITANO_KEY"].present?
    raise "REMITANO_SECRET is not set" unless ENV["REMITANO_SECRET"].present?
    config.key = ENV['REMITANO_KEY']
    config.secret = ENV['REMITANO_SECRET']
  end
end
