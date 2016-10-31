module Payable
  class Work < Resource
    attribute :worker_id, Types::Coercible::Int
    attribute :work_type_id, Types::Coercible::Int
    attribute :quantity, Types::Coercible::Decimal
    attribute :quantity_measure, Types::QuantityMeasure
    attribute :start, Types::Form::DateTime
    attribute :end, Types::Form::DateTime
    attribute :note, Types::String
    attribute :payment_id, Types::Coercible::Int
    attribute :payment_status, Types::PaymentStatus

    def self.collection; 'work'; end
  end
end