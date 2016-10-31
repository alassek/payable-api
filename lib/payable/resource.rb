require 'dry/struct'
require 'addressable/template'

module Payable
  class Resource < Dry::Struct
    constructor_type :schema

    attribute :id, Types::Strict::Int
    attribute :created_at, Types::Form::DateTime
    attribute :updated_at, Types::Form::DateTime

    def self.api_url
      Addressable::URI.parse Payable.config.api_url
    end

    def self.url_template
      Addressable::Template.new api_url.join("#{collection}/{id}")
    end

    def self.retrieve(id, client: Payable.client, params: {})
      response = client.get(url_template.expand(id: id), params)

      new(response.body)
    end

    def self.collection
      raise NotImplementedError if self == Payable::Resource

      @collection ||= begin
        collection = name.split('::').last
        collection = collection.split(/(?=[A-Z])/).map(&:downcase)

        "#{ collection.join('_') }s"
      end
    end

    def self.list(options = {})
      ResourceList.new(self, options)
    end

    def url
      self.class.url_template.expand(id: id)
    end
  end
end

require 'payable/worker'
require 'payable/work_type'
require 'payable/work'
require 'payable/payment'
