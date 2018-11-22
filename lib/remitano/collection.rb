module Remitano
  class Collection
    attr_accessor :path, :resource_name
    attr_accessor :config

    def initialize(config:)
      @config = config
      name = self.class.name.underscore.split("/").last
      self.resource_name = name.singularize
      self.path = "/#{name}"
    end

    def all
      config.net.new(config: config).get(self.path).execute
    end

    def create(params = {})
      config.net.new(config: config).post(self.path, { self.resource_name => params }).execute
    end

    def get(id)
      config.net.new(config: config).get("#{self.path}/#{id}").execute
    end

    def update(id, params = {})
      config.net.new(config: config).patch("#{self.path}/#{id}", { self.resource_name => params }).execute
    end
  end
end
