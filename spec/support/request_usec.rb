RSpec.configure do |config|
  config.before(:each) do
    allow_any_instance_of(Time).to receive(:usec).and_return 0
  end
end
