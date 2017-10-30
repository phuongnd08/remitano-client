require 'api-auth'

module Remitano
  class Net
    attr_reader :request

    def initialize(request)
      @request = request
    end

    def execute
      @request.execute do |res, req, result|
        if result.code =~ /^2\d\d$/
          return Remitano::Helper.parse_json(res)
        else
          raise "Error #{result.code} #{res}"
        end
      end
    end

    def self.to_uri(path)
      return "#{server}/api/v1#{path}"
    end

    def self.server
      @server ||= (ENV['REMITANO_SERVER'] || "https://remitano.com")
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
      new(req)
    end

    def self.get(path, params={})
      request = new_request(:get, path, params)
      sign_request(request)
    end

    def self.post(path, params={})
      request = new_request(:post, path, params)
      sign_request(request)
    end

    def self.patch(path, params={})
      request = new_request(:put, path, params)
      sign_request(request)
    end

    def self.delete(path, params={})
      request = new_request(:delete, path, params)
      sign_request(request)
    end

    def self.new_request(method, path, params=nil)
      options = {
        :url => self.to_uri(path),
        :method => method,
        :timeout => 20
      }
      options[:payload] = params.to_json if params

      RestClient::Request.new(options)
    end

    def self.sign_request(req)
      req.headers['Content-Type'] = 'application/json'
      ApiAuth.sign!(req, Remitano.key, Remitano.secret)
      new(req)
    end
  end
end
