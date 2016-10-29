require 'faraday'
require 'forwardable'
require 'addressable/uri'
require 'payable/middleware'

module Payable
  class Client
    extend Forwardable

    attr_reader :company_id, :api_key

    def initialize(company_id: Payable.config.company_id, api_key: Payable.config.api_key)
      @company_id = company_id
      @api_key    = api_key

      raise MissingRequiredSetting, "company_id" unless company_id
      raise MissingRequiredSetting, "api_key" unless api_key
    end

    def connection
      @connection ||= Faraday.new api_url do |conn|
        conn.basic_auth company_id, api_key
        conn.request :json
        conn.response :json
        conn.response :logger
        conn.response :symbolize_keys
        conn.adapter Faraday.default_adapter
      end
    end

    def_delegators :connection, :get, :post

    private

    def api_url
      Addressable::URI.parse Payable.config.api_url
    end
  end
end
