require 'payable/resource'

module Payable
  class WorkType < Resource
    def self.url_template
      Addressable::Template.new api_url.join('work_types/{id}')
    end

    attribute :quantity_measure, Types::Strict::String.enum('time', 'money', 'unit', 'distance')
    attribute :created_at, Types::Form::DateTime
    attribute :updated_at, Types::Form::DateTime

    def url
      self.class.url_template.expand(id: id)
    end
  end
end
