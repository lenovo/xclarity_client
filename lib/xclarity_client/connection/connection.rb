require 'faraday'
require 'faraday-cookie_jar'
require 'uri'
require 'uri/https'

module XClarityClient
  #
  # Handles the LXCA connection providing some services to interact
  # with the API.
  #
  class Connection
    #
    # @param [Hash] configuration - the data to create a connection with the LXCA
    # @option configuration [String] :host             the LXCA host
    # @option configuration [String] :username         the LXCA username
    # @option configuration [String] :password         the username password
    # @option configuration [String] :port             the LXCA port
    # @option configuration [String] :auth_type        the type of the authentication ('token', 'basic_auth')
    # @option configuration [String] :verify_ssl       ('PEER', 'NONE')
    # @option configuration [String] :user_agent_label Api gem client identification
    #
    def initialize(configuration)
      @connection = build(configuration)
    end

    #
    # Does a GET request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    # @param [Hash] query - params to query the endpoint resources
    #
    def do_get(uri = "", query = {})
      url_query = query.size > 0 ? "?" + query.map {|k, v| "#{k}=#{v}"}.join("&") : ""
      @connection.get(uri + url_query)
    rescue Faraday::Error::ConnectionFailed => e
      $lxca_log.error "XClarityClient::XclarityBase connection", "Error trying to send a GET to #{uri + url_query}"
      Faraday::Response.new
    end

    #
    # Does a POST request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    # @param [JSON] body  - json to be sent in request body
    #
    def do_post(uri = "", body = "")
      @connection.post do |req|
        req.url uri
        req.headers['Content-Type'] = 'application/json'
        req.body = body
      end
    rescue Faraday::Error::ConnectionFailed => e
      $lxca_log.error "XClarityClient::XclarityBase do_post", "Error trying to send a POST to #{uri}"
      $lxca_log.error "XClarityClient::XclarityBase do_post", "Request sent: #{body}"
      Faraday::Response.new
    end

    #
    # Does a PUT request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    # @param [JSON] body  - json to be sent in request body
    #
    def do_put(uri = "", body = "")
      @connection.put do |req|
        req.url uri
        req.headers['Content-Type'] = 'application/json'
        req.body = body
      end
    rescue Faraday::Error::ConnectionFailed => e
      $lxca_log.error "XClarityClient::XclarityBase do_put", "Error trying to send a PUT to #{uri}"
      $lxca_log.error "XClarityClient::XclarityBase do_put", "Request sent: #{body}"
      Faraday::Response.new
    end

    #
    # Does a DELETE request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    #
    def do_delete(uri = "")
      @connection.delete do |req|
        req.url uri
        req.headers['Content-Type'] = 'application/json'
      end
    end

    private

    def build(configuration)
      $lxca_log.info "XClarityClient::Connection build", "Building the connection"

      hostname = URI.parse(configuration.host)

      url = URI::HTTPS.build({ :host     => hostname.scheme ? hostname.host : hostname.path,
                               :port     => configuration.port.to_i,
                               :query    => hostname.query,
                               :fragment => hostname.fragment }).to_s

      $lxca_log.info "XClarityClient::XClarityBase connection_builder", "Creating connection to #{url}"

      connection = Faraday.new(url: url) do |faraday|
        faraday.request        :url_encoded             # form-encode POST params
        faraday.response       :logger, $lxca_log.log   # log requests to STDOUT -- This line, should be uncommented if you wanna inspect the URL Request
        faraday.use            :cookie_jar if configuration.auth_type == 'token'
        faraday.adapter        Faraday.default_adapter  # make requests with Net::HTTP
        faraday.ssl[:verify] = configuration.verify_ssl == 'PEER'
      end

      connection.headers[:user_agent] = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (configuration.user_agent_label.nil? ? "" : " (#{configuration.user_agent_label})")

      connection.basic_auth(configuration.username, configuration.password) if configuration.auth_type == 'basic_auth'
      $lxca_log.info "XClarityClient::XclarityBase connection_builder", "Connection created Successfuly"

      connection
    end
  end
end
