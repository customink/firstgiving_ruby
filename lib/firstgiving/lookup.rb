require 'crack'
# lookup API

module FirstGiving
  class Lookup
    include Base

    module Actions
      TRANSACTION_LIST = '/transaction/list'
      TRANSACTION_DETAIL = '/transaction/detail'
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

    def success_from(response)
      ack = response['firstGivingDonationApi']['firstGivingResponse']['acknowledgement']
      ack == 'Success' ? true : false
    end

    def params_from(response)
      params = response['firstGivingDonationApi']['firstGivingResponse']['transaction']
      params ||= response['firstGivingDonationApi']['firstGivingResponse']['transactions']
    end

    def message_from(response)
      response['firstGivingDonationApi']['firstGivingResponse']['verboseErrorMessage']
    end

    def parse(body)
      response = Crack::XML.parse(body)
      response = Response.new(success_from(response), message_from(response), params_from(response))
    end
  end
end
