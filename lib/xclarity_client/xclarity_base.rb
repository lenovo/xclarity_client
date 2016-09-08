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
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    private

    def connection(uri = "", options = {})
# puts "EU ESTOU AQUI 2 #{@conn.get(uri).body}"
# puts "EU ESTOU AQUI 2 #{uri}"
      @conn.get(uri)
    end
  end
end
