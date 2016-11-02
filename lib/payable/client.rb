require 'faraday'
require 'forwardable'
require 'addressable/uri'
require 'payable/middleware'

module Payable
  class Client
    extend Forwardable

    attr_reader :company_id, :api_key

    def initialize(company_id: Payable.config.company_id, api_key: Payable.config.api_key)
      @company_id = company_id or raise MissingRequiredSetting, "company_id"
      @api_key = api_key or raise MissingRequiredSetting, "api_key"
    end

    def connection
      @connection ||= Faraday.new Payable.api_url do |conn|
        conn.basic_auth company_id, api_key
        conn.request :json
        conn.response :json
        conn.response :logger, Payable.config.logger, bodies: true if Payable.config.logger
        conn.response :symbolize_keys
        conn.response :raise_error
        conn.adapter Faraday.default_adapter
      end
    end

    def_delegators :connection, :get, :post
  end
end
