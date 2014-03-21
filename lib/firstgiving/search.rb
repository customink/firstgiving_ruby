require 'json'

# Search API

module FirstGiving
  class Search
    include Base

    module Actions
      LIST_ORGANIZATION = '/v1/list/organization'
    end

    def initialize
      @api_endpoint = SEARCH_ENDPOINT
    end

    def headers
      { 'Accept' => 'application/json' }
    end

    def query(params)
      response = get_call(@api_endpoint, Actions::LIST_ORGANIZATION, params, headers)
      parse(response.body)
    end

    def parse(body)
      response = JSON.parse(body)
      response['payload']
    end
  end
end
