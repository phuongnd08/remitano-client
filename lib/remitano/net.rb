require 'api-auth'

module Remitano
  class Request
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
  end

  class Net
    attr_reader :remitano

    def initialize(remitano: nil)
      @remitano = remitano || Remitano.singleton
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
      Remitano::Request.new(req)
    end

    def get(path, params={})
      request = new_request(:get, path, params)
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

    def new_request(method, path, params={})
      p [:new_request, method, path] if remitano.verbose

      options = {
        :method => method,
        :timeout => 20
      }

      usec = Time.now.usec
      if method == :get
        path += (path.include?("?") ? "&" : "?")
        path += "usec=#{usec}"
      else
        params[:usec] = usec
        options[:payload] = params.to_json
      end

      options[:url] = Remitano::Net.to_uri(path)

      RestClient::Request.new(options)
    end

    def sign_request(req)
      req.headers['Content-Type'] = 'application/json'
      ApiAuth.sign!(req, remitano.key, remitano.secret)
      Remitano::Request.new(req)
    end
  end
end
