module Payable
  class Work < Resource
    attribute :worker_id, Types::Strict::Int
    attribute :work_type_id, Types::Strict::Int
    attribute :quantity, Types::Form::Decimal
    attribute :quantity_measure, Types::QuantityMeasure
    attribute :start, Types::Form::DateTime
    attribute :end, Types::Form::DateTime.optional
    attribute :notes, Types::String.optional
    attribute :payment_id, Types::Strict::Int.optional
    attribute :payment_status, Types::PaymentStatus

    def self.collection; 'work'; end

    extend Writeable
  end
end
