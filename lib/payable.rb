require 'dry/configurable'

module Payable
  extend Dry::Configurable

  setting :api_url, 'https://api.payable.com/v1/'
  setting :logger
  setting :page_size, 50

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

  Error                  = Class.new(StandardError)
  MissingRequiredSetting = Class.new(Error)

  class InvalidRequest < Error
    attr_reader :response

    def initialize(response = {})
      @response = response
      super
    end

    def response?
      return false if response.nil?
      return false if response.respond_to?(:empty?) && response.empty?
      !!response
    end

    def status
      return nil unless response
      response[:status]
    end

    def headers
      return nil unless response
      response[:headers]
    end

    def body
      return nil unless response
      respose[:body]
    end
  end
end

require 'payable/types'
require 'payable/client'
require 'payable/resource'
require 'payable/resource_list'
