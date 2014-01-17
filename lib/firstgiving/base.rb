require 'faraday'

module FirstGiving

  module Base

    DONATION_SANDBOX_ENDPOINT    = "http://usapisandbox.fgdev.net"
    DONATION_PRODUCTION_ENDPOINT = "https://api.firstgiving.com"
    SEARCH_ENDPOINT = "http://graphapi.firstgiving.com"

    def headers_json
      {
        'User-Agent'        => 'FirstGiving Ruby SDK',
        'Content-Type'      => 'application/json'
      }
    end

    def headers_security
      {
        'JG_APPLICATIONKEY' => "#{FirstGiving.configuration.application_key}",
        'JG_SECURITYTOKEN'  => "#{FirstGiving.configuration.security_token}"
      }
    end

    def post_call(api_endpoint, action, params, headers)
      conn = Faraday.new(:url => api_endpoint) do |faraday|
        faraday.request  :url_encoded
        faraday.adapter  Faraday.default_adapter
      end

      response = conn.post do |req|
        req.url action
        req.params = params
        req.headers = headers
      end
    end

    def get_call(api_endpoint, action, params, headers)
      conn = Faraday.new(:url => api_endpoint) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end

      response = conn.get do |req|
        req.url action
        req.params = params
        req.headers = headers
      end
    end

    def logging(msg)
      puts "[FG-LOG] #{msg}" if FirstGiving.configuration.options[:verbose]
    end

  end
end

