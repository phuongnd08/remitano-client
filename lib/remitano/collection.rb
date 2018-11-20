module Remitano
  class Collection
    attr_accessor :path, :resource_name
    attr_accessor :remitano

    def initialize(remitano: nil)
      @remitano = remitano || Remitano.singleton
      name = self.class.name.underscore.split("/").last
      self.resource_name = name.singularize
      self.path = "/#{name}"
    end

    def all
      remitano.net.new(remitano: remitano).get(self.path).execute
    end

    def create(params = {})
      remitano.net.new(remitano: remitano).post(self.path, { self.resource_name => params }).execute
    end

    def get(id)
      remitano.net.new(remitano: remitano).get("#{self.path}/#{id}").execute
    end

    def update(id, params = {})
      remitano.net.new(remitano: remitano).patch("#{self.path}/#{id}", { self.resource_name => params }).execute
    end
  end
end
