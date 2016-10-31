require 'dry/types'

module Payable
  module Types
    include Dry::Types.module

    QuantityMeasure = Strict::String.enum('time', 'money', 'unit', 'distance')
    InviteStatus    = Strict::String.enum('invited', 'not_invited', 'accepted')
    PaymentStatus   = Strict::String.enum('draft_ready', 'payment_pending', 'payment_failed', 'payment_refunded', 'paid')
  end
end
