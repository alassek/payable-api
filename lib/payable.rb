require 'dry/configurable'

module Payable
  extend Dry::Configurable

  setting :api_version
  setting :api_url, 'https://api.payable.com/v1/'

  setting :company_id
  setting :api_key

  def self.client
    @client ||= Client.new
  end

  def self.client=(instance)
    @client = instance
  end

  MissingRequiredSetting = Class.new(StandardError)
  InvalidRequest         = Class.new(StandardError)
end

require 'payable/types'
require 'payable/client'
require 'payable/work_type'
