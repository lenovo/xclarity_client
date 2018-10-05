require 'json'

module XClarityClient
  class XClarityCredentialsValidator
    BASE_URI = '/sessions'.freeze

    def initialize(conf)
      @connection = XClarityClient::Connection.new(conf)
      @configuration = conf
    end

    def validate
      $lxca_log.info 'XClarityClient::XClarityValidate validate', 'Creating session ...'
      build_session(@configuration)

      id_session = JSON.parse(@response.body)['messages'].first['id']
      $lxca_log.info 'XClarityClient::XClarityValidate validate', 'Session created ...'

      close_session(id_session)
    rescue => err
      cause = err.cause.to_s.downcase
      if cause.include?('connection refused')
        raise XClarityClient::Error::ConnectionRefused
      elsif cause.include?('name or service not known')
        raise XClarityClient::Error::HostnameUnknown
      elsif @response.nil?
        raise XClarityClient::Error::ConnectionFailed
      elsif @response.status == 403
        raise XClarityClient::Error::AuthenticationError
      else
        raise XClarityClient::Error::ConnectionFailedUnknown.new("status #{@response.status}")
      end
    end

    def build_session(conf)
      @response = @connection.do_post(BASE_URI, {
        :UserId => conf.username,
        :password => conf.password
      }.to_json)

      raise Faraday::Error::ConnectionFailed unless @response.success?
    end

    def close_session(id_session)
      @connection.do_delete("#{BASE_URI}/#{id_session}")
    end
  end
end
