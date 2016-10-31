require 'payable/resource'

module Payable
  class WorkType < Resource
    attribute :name, Types::String
    attribute :quantity_measure, Types::Strict::String.enum('time', 'money', 'unit', 'distance')
  end
end
