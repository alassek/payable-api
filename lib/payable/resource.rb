require 'dry/struct'
require 'addressable/template'

module Payable
  class Resource < Dry::Struct
    def self.api_url
      Addressable::URI.parse Payable.config.api_url
    end

    def self.url_template
      raise NotImplementedError
    end

    def self.retrieve(id, client: Payable.client, http: {})
      client.get(url_template.expand(id), http)
    end

    attribute :id, Types::Coercible::Int
  end
end
