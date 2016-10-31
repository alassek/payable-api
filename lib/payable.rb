require 'dry/configurable'

module Payable
  extend Dry::Configurable

  setting :api_url, 'https://api.payable.com/v1/'
  setting :logger

  setting :company_id
  setting :api_key

  def self.api_url
    Addressable::URI.parse config.api_url
  end

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
require 'payable/resource_list'
require 'payable/work_type'
