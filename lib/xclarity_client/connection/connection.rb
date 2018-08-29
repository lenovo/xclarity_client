require 'faraday'
require 'faraday-cookie_jar'
require 'uri'
require 'uri/https'
require 'timeout'

module XClarityClient
  #
  # Handles the LXCA connection providing some services to interact
  # with the API.
  #
  class Connection
    HEADER_MESSAGE = 'XClarityClient::Connection'.freeze
    #
    # @param [Hash] configuration - the data to create a connection with the LXCA
    # @option configuration [String] :host             the LXCA host
    # @option configuration [String] :username         the LXCA username
    # @option configuration [String] :password         the username password
    # @option configuration [String] :port             the LXCA port
    # @option configuration [String] :auth_type        the type of the authentication ('token', 'basic_auth')
    # @option configuration [String] :verify_ssl       ('PEER', 'NONE')
    # @option configuration [String] :user_agent_label Api gem client identification
    # @option configuration [String] :timeout          the limit time in seconds
    #
    def initialize(configuration)
      @connection = build(configuration)
      @timeout    = configuration.timeout
    end

    #
    # Does a GET request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    # @param [Hash] query - params to query the endpoint resources
    # @param [Hash] headers - add headers to the request
    #
    def do_get(uri = "", query: {}, headers: {})
      url_query = query.size > 0 ? "?" + query.map {|k, v| "#{k}=#{v}"}.join("&") : ""
      Timeout.timeout(@timeout) do
        @connection.get do |req|
          req.url(uri + url_query)
          headers.map { |key, value| req.headers[key] = value }
        end
      end
    rescue Faraday::Error::ConnectionFailed, Timeout::Error => e
      msg = "Error trying to send a GET to #{uri + url_query} "\
            "the reason: #{e.message}"
      $lxca_log.error(HEADER_MESSAGE + ' do_get', msg)
      Faraday::Response.new
    end

    #
    # Does a POST request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    # @param [JSON] body  - json to be sent in request body
    #
    def do_post(uri = '', body = '')
      build_request(:post, uri, body)
    end

    #
    # Does a PUT request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    # @param [JSON] body  - json to be sent in request body
    #
    def do_put(uri = '', body = '')
      build_request(:put, uri, body)
    end

    #
    # Does a DELETE request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    #
    def do_delete(uri = '')
      build_request(:delete, uri)
    end

    private

    def build_request(method, url, body = '')
      @connection.send(method) do |request|
        request.url(url)
        request.headers['Content-Type'] = 'application/json'
        request.body = body
      end
    rescue Faraday::Error::ConnectionFailed => e
      header = HEADER_MESSAGE + " do_#{method}"
      msg = "Error trying to send a #{method} to #{url} " \
            "the reason: #{e.message}"
      $lxca_log.error(header, msg)
      $lxca_log.error(header, "Request sent: #{body}")
      Faraday::Response.new
    end

    def build(configuration)
      header = HEADER_MESSAGE + ' build'
      $lxca_log.info(header, 'Building the connection')

      hostname = URI.parse(configuration.host)

      url = URI::HTTPS.build({ :host     => hostname.scheme ? hostname.host : hostname.path,
                               :port     => configuration.port.to_i,
                               :query    => hostname.query,
                               :fragment => hostname.fragment }).to_s
      $lxca_log.info(header, "Creating connection to #{url}")

      connection = Faraday.new(url: url) do |faraday|
        faraday.request(:url_encoded) # form-encode POST params
        faraday.response(:logger, $lxca_log.log) # log requests to log file
        faraday.use(:cookie_jar) if configuration.auth_type == 'token'
        faraday.adapter(:httpclient) # make requests with HTTPClient
        faraday.ssl[:verify] = configuration.verify_ssl == 'PEER'
      end

      connection.headers[:user_agent] = "LXCA via Ruby Client/#{XClarityClient::VERSION}" + (configuration.user_agent_label.nil? ? "" : " (#{configuration.user_agent_label})")

      connection.basic_auth(configuration.username, configuration.password) if configuration.auth_type == 'basic_auth'
      $lxca_log.info(header, 'Connection created Successfuly')

      connection
    end
  end
end
