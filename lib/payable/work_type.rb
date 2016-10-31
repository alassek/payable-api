require 'payable/resource'

module Payable
  class WorkType < Resource
    attribute :name, Types::String
    attribute :quantity_measure, Types::QuantityMeasure
  end
end
