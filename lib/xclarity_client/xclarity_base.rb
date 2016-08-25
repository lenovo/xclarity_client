require 'faraday'

module XClarityClient
  class XClarityBase

    attr_reader :conn

    def initialize(conf, uri)
      connection(conf, uri)
    end

    def connection(conf, uri)
      @conn = Faraday.new(:url => conf.host + uri) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end
