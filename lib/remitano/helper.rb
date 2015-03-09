module Remitano
  module Helper
    def self.parse_array(string)
      JSON.parse(string).map do |hash|
        Hashie::Mash[hash]
      end
    end

    def self.parse_object(string)
      Hashie::Mash[JSON.parse(string)]
    end
  end
end
