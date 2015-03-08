module Remitano
  module Net
    def self.to_uri(path)
      return "https://www.remitano.net/api#{path}/"
    end

    def self.get(path, options={})
      RestClient.get(self.to_uri(path))
    end

    def self.post(path, options={})
      RestClient.post(self.to_uri(path), self.remitano_options(options))
    end

    def self.patch(path, options={})
      RestClient.put(self.to_uri(path), self.remitano_options(options))
    end

    def self.delete(path, options={})
      RestClient.delete(self.to_uri(path), self.remitano_options(options))
    end

    def self.remitano_options(options={})
      if Remitano.configured?
        options[:key] = Remitano.key
        options[:nonce] = (Time.now.to_f*10000).to_i.to_s
        options[:signature] = HMAC::SHA256.hexdigest(Remitano.secret, options[:nonce]+Remitano.client_id.to_s+options[:key]).upcase
      end

      options
    end
  end
end
