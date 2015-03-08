module Remitano
  class Collection
    attr_accessor :access_token, :module, :name, :model, :path

    def initialize(api_prefix="/api")
      self.access_token = Remitano.key

      self.module = self.class.to_s.singularize.underscore
      self.name   = self.module.split('/').last
      self.model  = self.module.camelize.constantize
      self.path   = "#{api_prefix}/#{self.name.pluralize}"
    end

    def all(options = {})
      Remitano::Helper.parse_objects! Remitano::Net::get(self.path).to_str, self.model
    end

    def create(options = {})
      Remitano::Helper.parse_object! Remitano::Net::post(self.path, options).to_str, self.model
    end

    def find(id, options = {})
      Remitano::Helper.parse_object! Remitano::Net::get("#{self.path}/#{id}").to_str, self.model
    end

    def update(id, options = {})
      Remitano::Helper.parse_object! Remitano::Net::patch("#{self.path}/#{id}", options).to_str, self.model
    end
  end
end
