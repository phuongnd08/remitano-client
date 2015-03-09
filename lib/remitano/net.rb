module Remitano
  module Net
    def self.to_uri(path)
      return "#{server}/api/v1#{path}"
    end

    def self.server
      @server ||= (ENV['REMITANO_SERVER'] || "https://remitano.com")
    end

    def self.get(path, params={})
      RestClient.get(self.to_uri(path), params, auth_headers)
    end

    def self.post(path, params={})
      RestClient.post(self.to_uri(path), params, auth_headers)
    end

    def self.patch(path, params={})
      RestClient.put(self.to_uri(path), params, auth_headers)
    end

    def self.delete(path, params={})
      RestClient.delete(self.to_uri(path), params, auth_headers)
    end

    def self.auth_headers
      nonce = (Time.now.to_f * 10000).to_i.to_s
      signature = HMAC::SHA256.hexdigest(
        Remitano.secret,
        options[:nonce]+Remitano.client_id.to_s+options[:key]
      ).upcase

      {
        :key => Remitano.key,
        :nonce => nonce
        :signature => signature
      }
    end
  end
end
