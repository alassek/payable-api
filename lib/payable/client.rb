require 'faraday'
require 'addressable/uri'

module Payable
  class Client
    attr_reader :company_id, :api_key

    def initialize(company_id: Payable.config.company_id, api_key: Payable.config.api_key)
      @company_id = company_id
      @api_key    = api_key

      raise MissingRequiredSetting, "company_id" unless company_id
      raise MissingRequiredSetting, "api_key" unless api_key
    end

    def connection
      raise NotImplementedError
    end

    private

    def api_url
      Addressable::URI.parse Payable.config.api_url
    end
  end
end
