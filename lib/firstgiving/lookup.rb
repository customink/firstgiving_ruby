require 'crack'
# lookup API

module FirstGiving

  class Lookup

    include Base

    module Actions
      TRANSACTION_LIST = "/transaction/list"
      TRANSACTION_DETAIL = "/transaction/detail"
    end

    def initialize
      @api_endpoint = DONATION_PRODUCTION_ENDPOINT
      @api_endpoint = DONATION_SANDBOX_ENDPOINT if FirstGiving.configuration.options[:use_staging]
    end

    def headers
      headers_json.merge!(headers_security)
    end

    def call(action, params, _headers)
      response = get_call(@api_endpoint, action, params, _headers)
      parse(response.body)
    end

    def detail(params)
      call(Actions::TRANSACTION_DETAIL, params, headers)
    end

    def list(params)
      call(Actions::TRANSACTION_LIST, params, headers)
    end

    def parse(body)
      Crack::XML.parse(body)
    end
  end

end
