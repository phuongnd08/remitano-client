RSpec.configure do |config|
  config.before(:each) do
    # The famous singleton problem
    Remitano.setup do |config|
      config.key = nil
      config.secret = nil
      config.client_id = nil
    end
  end
end

def setup_remitano
  Remitano.setup do |config|
    raise "You must set environment variable REMITANO_KEY and REMITANO_SECRET with your username and password to run specs." if ENV['REMITANO_KEY'].nil? or ENV['REMITANO_SECRET'].nil?
    config.key = ENV['REMITANO_KEY']
    config.secret = ENV['REMITANO_SECRET']
  end
end
