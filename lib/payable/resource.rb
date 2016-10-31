require 'dry/struct'
require 'addressable/template'

module Payable
  class Resource < Dry::Struct
    attribute :id, Types::Coercible::Int

    def self.api_url
      Addressable::URI.parse Payable.config.api_url
    end

    def self.url_template
      raise NotImplementedError
    end

    def self.retrieve(id, client: Payable.client, params: {})
      response = client.get(url_template.expand(id: id), params)

      new(response.body)
    end

    def self.collection
      @collection ||= begin
        collection = name.split('::').last
        collection = collection.split(/(?=[A-Z])/).map(&:downcase)

        "#{ collection.join('_') }s"
      end
    end

    def self.list(page_size: 50)
      ResourceList.new(self, page_size: page_size)
    end
  end
end
