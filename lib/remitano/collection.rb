module Remitano
  class Collection
    attr_accessor :path

    def initialize
      self.path   = "/#{self.class.name.underscore.split("/").last.pluralize}"
    end

    def all(params = {})
      Remitano::Helper.parse_array Remitano::Net::get(self.path)
    end

    def create(params = {})
      Remitano::Helper.parse_object Remitano::Net::post(self.path, params)
    end

    def find(id, params = {})
      Remitano::Helper.parse_object Remitano::Net::get("#{self.path}/#{id}")
    end

    def update(id, params = {})
      Remitano::Helper.parse_object Remitano::Net::patch("#{self.path}/#{id}", params)
    end
  end
end
