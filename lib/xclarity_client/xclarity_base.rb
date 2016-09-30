require 'faraday'

module XClarityClient
  class XClarityBase

    attr_reader :conn

    def initialize(conf, uri)
      connection_builder(conf, uri)
    end

    def connection_builder(conf, uri)
      @conn = Faraday.new(url: conf.host + uri) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        # faraday.response :logger                  # log requests to STDOUT -- This line must be uncommented when necessary
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    private

    def connection(uri = "", options = {})
      @conn.get(uri)
    end
  end
end
