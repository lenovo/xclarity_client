require 'faraday'
require 'json'
require 'uri'
require 'openssl'
   OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE # -- this is to

module XClarityClient
  class XClarityBase

    token_auth = '/session'.freeze

    attr_reader :conn

    def initialize(conf, uri)
      connection_builder(conf, uri)
    end

    def connection_builder(conf, uri)

      #Building configuration
      @conn = Faraday.new(url: conf.host) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        # faraday.response :logger                  # log requests to STDOUT -- Uncomment this line when you want inspect request logs.
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end

      response = authentication(conf) unless conf.auth_type != 'token'
      #TODO: What's to do with the response of authentication request?
      @conn.basic_auth(conf.username, conf.password) unless conf.auth_type != 'basic_auth'

      @conn
    end

    def connection(uri = "", options = {})
      @conn.get(uri)
    end

    def authentication(conf)
      response = @conn.post do |request|
        request.url '/session'
        request.headers['Content-Type'] = 'application/json'
        request.body = {:UserId => conf.username,
                        :password => conf.password,
                        :heartBeatEnabled => true,
                        :maxLostHeartBeats => 3,
                        :csrf => conf.csrf_token}.to_json
      end
    end
  end
end
