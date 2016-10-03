require 'faraday'
require 'uri'

module XClarityClient
  class XClarityBase

    attr_reader :conn

    def initialize(conf, uri)
      connection_builder(conf, uri)
    end

    def connection_builder(conf, uri)

      @conn = Faraday.new(url: conf.host + uri) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        # faraday.response :logger                  # log requests to STDOUT -- Uncomment this line if you have to inspect the request log
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def connection(uri = "", options = {})
      @conn.get(uri)
    end
  end
end
