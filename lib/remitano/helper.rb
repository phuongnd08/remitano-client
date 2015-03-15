module Remitano
  module Helper
    def self.parse_json(str)
      json = JSON.parse(str)
      if json.is_a? Array
        json.map do |hash|
          Hashie::Mash[hash]
        end
      else
        Hashie::Mash[json]
      end
    end
  end
end
