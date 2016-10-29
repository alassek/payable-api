require 'faraday_middleware'
require 'faraday/response'

module Payable
  module Middleware
    class SymbolizeKeys < FaradayMiddleware::ParseJson
      define_parser do |body|
        break if body.strip.empty?
        symbolize_keys ::JSON.parse(body)
      end

      def self.symbolize_keys(hash)
        hash.inject({}) do |result, (key, value)|
          new_key = case key
          when String then key.to_sym
          else key
          end

          new_value = case value
          when Hash then symbolize_keys(value)
          else value
          end

          result[new_key] = new_value

          result
        end
      end
    end
  end
end

Faraday::Response.register_middleware symbolize_keys: Payable::Middleware::SymbolizeKeys
