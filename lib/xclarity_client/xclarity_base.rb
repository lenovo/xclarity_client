require 'faraday'
require 'json'
require 'uri'
require 'uri/https'

module XClarityClient
  class XClarityBase

    token_auth = '/session'.freeze
    attr_reader :conn
    
    def initialize(conf, uri)
      connection_builder(conf, uri)
    end

    def connection_builder(conf, uri)
      $lxca_log.info "XClarityClient::XClarityBase connection_builder", "Building the url"
      #Building configuration
      hostname = URI.parse(conf.host)
      url = URI::HTTPS.build({ :host     => hostname.scheme ? hostname.host : hostname.path,
                               :port     => conf.port.to_i,
                               :path     => uri,
                               :query    => hostname.query,
                               :fragment => hostname.fragment }).to_s

      $lxca_log.info "XClarityClient::XClarityBase connection_builder", "Creating connection to #{url}"

      @conn = Faraday.new(url: url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT -- This line, should be uncommented if you wanna inspect the URL Request
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        faraday.ssl[:verify] = conf.verify_ssl == 'PEER'
      end

      response = authentication(conf) unless conf.auth_type != 'token'
      #TODO: What's to do with the response of authentication request?
      @conn.basic_auth(conf.username, conf.password) if conf.auth_type == 'basic_auth'
      $lxca_log.info "XClarityClient::XclarityBase connection_builder", "Connection created Successfuly"
      @conn
    end

    private

    def connection(uri = "", opts = {})
      query = opts.size > 0 ? "?" + opts.map {|k, v| "#{k}=#{v}"}.join(",") : ""
      begin
        @conn.get(uri + query)
      rescue Faraday::Error::ConnectionFailed => e
        $lxca_log.error "XClarityClient::XclarityBase connection", "Error trying to send a GET to #{uri + query}"
        Faraday::Response.new
      end
    end

    def do_post(uri="", request = {})
      begin
        @conn.post do |req|
          req.url uri
          req.headers['Content-Type'] = 'application/json'
          req.body = request
        end
      rescue Faraday::Error::ConnectionFailed => e
        $lxca_log.error "XClarityClient::XclarityBase do_post", "Error trying to send a POST to #{uri}"
        $lxca_log.error "XClarityClient::XclarityBase do_post", "Request sent: #{request}"
        Faraday::Response.new
      end
    end

    def do_put (uri="", request = {})
      begin
        @conn.put do |req|
          req.url uri
          req.headers['Content-Type'] = 'application/json'
          req.body = request
        end
      rescue Faraday::Error::ConnectionFailed => e
        $lxca_log.error "XClarityClient::XclarityBase do_put", "Error trying to send a PUT to #{uri}"
        $lxca_log.error "XClarityClient::XclarityBase do_put", "Request sent: #{request}"
        Faraday::Response.new
      end
    end

    def do_delete (uri="")
      @conn.delete do |req|
        req.url uri
        req.headers['Content-Type'] = 'application/json'
      end
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
