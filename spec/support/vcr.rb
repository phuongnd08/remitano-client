require 'vcr'
require 'webmock/rspec'
require_relative 'crendentials'

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
  c.configure_rspec_metadata!
  c.default_cassette_options = { record: :once }
  %w(REMITANO_KEY REMITANO_SECRET REMITANO_SERVER).each do |key|
    c.filter_sensitive_data(key) do |interaction|
      ENV[key]
    end
  end
end

RSpec.configure do |c|
  # so we can use :vcr rather than :vcr => true;
  # in RSpec 3 this will no longer be necessary.
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
