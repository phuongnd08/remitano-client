RSpec.configure do |config|
  config.before(:each) do
    Remitano.configure do |config|
      config.key = ENV['REMITANO_KEY']
      config.secret = ENV['REMITANO_SECRET']
    end
  end
end
