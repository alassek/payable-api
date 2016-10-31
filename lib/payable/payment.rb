module Payable
  class Payment < Resource
    attribute :worker_id, Types::Coercible::Int
    attribute :amount, Types::Coercible::Int
    attribute :status, Types::PaymentStatus
    attribute :notes, Types::String
    attribute :sent_at, Types::Form::DateTime
    attribute :paid_at, Types::Form::DateTime
  end
end
