module Remitano
  class Collection
    attr_accessor :path, :resource_name

    def initialize
      name = self.class.name.underscore.split("/").last
      self.resource_name = name.singularize
      self.path = "/#{name}"
    end

    def all
      Remitano::Helper.parse_array Remitano::Net::get(self.path)
    end

    def create(params = {})
      Remitano::Helper.parse_object Remitano::Net::post(self.path, { self.resource_name => params })
    end

    def get(id)
      Remitano::Helper.parse_object Remitano::Net::get("#{self.path}/#{id}")
    end

    def update(id, params = {})
      Remitano::Helper.parse_object Remitano::Net::patch("#{self.path}/#{id}", { self.resource_name => params })
    end
  end
end
