require 'payable/resource'

module Payable
  class WorkType < Resource
    attribute :name, Types::String
    attribute :quantity_measure, Types::Strict::String.enum('time', 'money', 'unit', 'distance')
    attribute :created_at, Types::Form::DateTime
    attribute :updated_at, Types::Form::DateTime

    def self.url_template
      Addressable::Template.new api_url.join('work_types/{id}')
    end

    def url
      self.class.url_template.expand(id: id)
    end

    def inspect
      %Q(#<Payable::WorkType id=#{id} name="#{name}" quantity_measure=#{quantity_measure} created_at=#{created_at.iso8601} updated_at=#{updated_at.iso8601}>)
    end
  end
end
