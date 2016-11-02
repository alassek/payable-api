module Payable
  module Writeable
    def create(params = {})
      client = params.delete(:client){ Payable.client }
      new client.post(api_url.join(collection), params).body
    rescue Faraday::ClientError => e
      raise InvalidRequest.new(e.response), e.message
    end
  end
end
