ENV['REMITANO_KEY'] = 'key'
ENV['REMITANO_SECRET'] = 'secret'
ENV['REMITANO_AUTHENTICATOR_SECRET'] = 'secret'
ENV["REMITANO_SERVER"] = "http://localhost:3100"

RSpec.configure do |config|
  config.before(:each) do
    Remitano::Client.default_key = ENV['REMITANO_KEY']
    Remitano::Client.default_secret = ENV['REMITANO_SECRET']
    Remitano::Client.default_authenticator_secret = ENV['REMITANO_SECRET']
  end
end
