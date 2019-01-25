require 'faraday'
require 'faraday-cookie_jar'
require 'uri'
require 'uri/https'
require 'timeout'
require 'open-uri'

module XClarityClient
  #
  # Handles the LXCA connection providing some services to interact
  # with the API.
  #
  class Connection
    HEADER_MESSAGE = 'XClarityClient::Connection'.freeze
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
      @connection_multipart = build(configuration, true)
      @connection_net_http = build(configuration, false, true)
      @timeout = configuration.timeout
      @configuration = configuration
    end

    # Does a GET request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    # @param [Hash] query - params to query the endpoint resources
    # @param [Hash] headers - add headers to the request
    #
    def do_get(uri = "", query: {}, headers: {}, n_http: false)
      url_query = query.size > 0 ? "?" + query.map {|k, v| "#{k}=#{v}"}.join("&") : ""
      Timeout.timeout(@timeout) do
        con = n_http ? @connection_net_http : @connection
        con.get do |req|
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

    def do_get_file_download(uri, file_path)
      host = @configuration.host
      username = @configuration.username
      password = @configuration.password
      url = 'https://' + host + uri
      open(file_path, 'wb') do |file|
        open(url, :ssl_verify_mode           => 0,
                  :http_basic_authentication => [username, password]) do |res|
          file.write(res.read)
        end
      end
    rescue OpenURI::HTTPError => error
      response = error.io
      msg = "Error while trying to #{uri} "\
            "the reason: #{response.status}"
      $lxca_log.error(' do_get_file_download', msg)
    end

    # Does a POST request to an LXCA endpoint
    #
    # @param [String] uri - endpoint to do the request
    # @param [JSON] body  - json to be sent in request body
    #
    def do_post(uri = '', body = '', multipart = false)
      build_request(:post, uri, body, multipart)
    end

    # Does a PUT request to an LXCA endpoint
    # @param [String] uri - endpoint to do the request
    # @param [JSON] body  - json to be sent in request body
    def do_put(uri = '', body = '')
      build_request(:put, uri, body)
    end

    # Does a DELETE request to an LXCA endpoint
    # @param [String] uri - endpoint to do the request
    def do_delete(uri = '')
      build_request(:delete, uri)
    end

    private

    def build_request(method, url, body = '', multipart = false)
      con = multipart ? @connection_multipart : @connection
      con.send(method) do |request|
        request.url(url)
        request.headers['Content-Type'] = 'application/json' unless multipart
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

    def create_connection_obj(connection, configuration)
      user_agent_label = configuration.user_agent_label
      agent_label = user_agent_label.nil? ? "" : user_agent_label
      header = "LXCA via Ruby Client/#{XClarityClient::VERSION}"
      connection.headers[:user_agent] = header + agent_label
      basic_auth = configuration.auth_type == 'basic_auth'
      username = configuration.username
      password = configuration.password
      connection.basic_auth(username, password) if basic_auth
      $lxca_log.info(header, 'Connection created Successfuly')
      connection
    end

    def create_faraday_obj(url, configuration, multipart, n_http)
      Faraday.new(url: url) do |faraday|
        faraday.request(:multipart) if multipart # multipart form data
        faraday.request(:url_encoded) # form-encode POST params
        faraday.response(:logger, $lxca_log.log) # log requests to log file
        faraday.use(:cookie_jar) if configuration.auth_type == 'token'
        faraday.adapter(:httpclient) unless n_http || multipart
        faraday.adapter(:net_http) if n_http || multipart # with net_http
        faraday.ssl[:verify] = configuration.verify_ssl == 'PEER'
      end
    end

    def build_connection(url, configuration, multipart = false, n_http = false)
      con_obj = create_faraday_obj(url, configuration, multipart, n_http)
      create_connection_obj(con_obj, configuration)
    end

    def build(configuration, multipart = false, n_http = false)
      header = HEADER_MESSAGE + ' build'
      $lxca_log.info(header, 'Building the connection')
      hostname = URI.parse(configuration.host)
      host = hostname.scheme ? hostname.host : hostname.path
      url = URI::HTTPS.build(:host     => host,
                             :port     => configuration.port.to_i,
                             :query    => hostname.query,
                             :fragment => hostname.fragment).to_s
      $lxca_log.info(header, "Creating connection to #{url}")
      build_connection(url, configuration, multipart, n_http)
    end
  end
end
