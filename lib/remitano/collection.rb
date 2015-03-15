module Remitano
  class Collection
    attr_accessor :path, :resource_name

    def initialize
      name = self.class.name.underscore.split("/").last
      self.resource_name = name.singularize
      self.path = "/#{name}"
    end

    def all
      Remitano::Net::get(self.path).execute
    end

    def create(params = {})
      Remitano::Net::post(self.path, { self.resource_name => params }).execute
    end

    def get(id)
      Remitano::Net::get("#{self.path}/#{id}").execute
    end

    def update(id, params = {})
      Remitano::Net::patch("#{self.path}/#{id}", { self.resource_name => params }).execute
    end
  end
end
