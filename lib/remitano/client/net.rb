# frozen_string_literal: true

require "api-auth"

module Remitano
  class Client::Request
    class RequestError < StandardError; end

    def initialize(request)
      @request = request
    end

    def execute
      @request.execute do |res, req, result|
        if result.code =~ /^2\d\d$/
          return Remitano::Client::Helper.parse_json(res)
        else
          raise RequestError.new("Error #{result.code} #{res}")
        end
      end
    end
  end

  class Client::Net
    attr_reader :config

    REMITANO_PRODUCTION_SERVER = "https://api.remitano.com"
    REMITANO_SANDBOX_SERVER = "https://api.remidemo.com"

    def initialize(config:)
      @config = config
    end

    def self.to_uri(path, api_version = "v1")
      api_version ||= "v1"
      "#{server}/api/#{api_version}#{path}"
    end

    def self.server
      ENV["REMITANO_SERVER"] ||
        (ENV["REMITANO_SANDBOX"] == "true" ? REMITANO_SANDBOX_SERVER : REMITANO_PRODUCTION_SERVER)
    end

    def self.public_get(path, params = {})
      options = {
        :url => self.to_uri(path),
        :method => :get,
        :timeout => 20,
        :headers => {
          :params => params,
          :lang => "vi"
        }
      }
      req = RestClient::Request.new(options)
      req.headers['Content-Type'] = 'application/json'
      Remitano::Client::Request.new(req)
    end

    def get(path, params={}, api_config={})
      request = new_request(:get, path, params, api_config)
      sign_request(request)
    end

    def post(path, params={})
      request = new_request(:post, path, params)
      sign_request(request)
    end

    def patch(path, params={})
      request = new_request(:put, path, params)
      sign_request(request)
    end

    def delete(path, params={})
      request = new_request(:delete, path, params)
      sign_request(request)
    end

    def new_request(method, path, params={}, api_config={})
      p [:new_request, method, path] if config.verbose

      options = {
        :method => method,
        :timeout => 20
      }

      usec = Time.now.usec
      if method == :get
        uri = URI(path)
        request_params = URI.decode_www_form(uri.query || "")
        request_params.concat(params.to_a)
        request_params << ["usec", usec]
        uri.query = URI.encode_www_form(request_params)
        path = uri.to_s
      else
        params[:usec] = usec
        options[:payload] = params.to_json
      end
      options[:url] = self.class.to_uri(path, api_config[:api_version])

      RestClient::Request.new(options)
    end

    def sign_request(req)
      req.headers['Content-Type'] = 'application/json'
      ApiAuth.sign!(req, config.key, config.secret)
      Remitano::Client::Request.new(req)
    end
  end
end
