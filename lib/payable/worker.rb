module Payable
  class Worker < Resource
    attribute :display_name, Types::String
    attribute :first_name, Types::String
    attribute :last_name, Types::String
    attribute :email, Types::String
    attribute :signed_up, Types::Bool
    attribute :invite_status, Types::InviteStatus
    attribute :payable, Types::Bool

    extend Writeable
    def self.create(params = {})
      raise InvalidRequest, "display_name is a required parameter" unless params[:display_name]
      super
    end
  end
end
