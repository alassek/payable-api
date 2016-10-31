require 'dry/types'

module Payable
  module Types
    include Dry::Types.module

    QuantityMeasure = Strict::String.enum('time', 'money', 'unit', 'distance')
  end
end
