require 'securerandom'

module XClarityClient
  class Configuration

    attr_accessor :username, :password, :host, :csrf_token, :auth_type, :generated_token, :port, :verify_ssl

    def initialize(args)

      args.each { |key, value| send("#{key}=", value) }

      if [username, password, host, port, verify_ssl].any? { |item| item.nil? }
        $lxca_log.error "XClarityClient::Configuration initialize","username, password, host, port and verify_ssl must all be specified"
        raise ArgumentError, "username, password, host, port and verify_ssl must all be specified"
      end

      if ( not is_valid_port(port) ) or host == ""
        $lxca_log.error "XClarityClient::Configuration initialize","port number and host must be valid"
        raise ArgumentError, "port number and host must be valid"
      end

      if not @auth_type.is_a?(String) or @auth_type == ''
        @auth_type = 'basic_auth'
      end

      $lxca_log.info "XClarityClient::Configuration initialize","Configuration built successfuly"
      
      @csrf_token ||= SecureRandom.base64(120) if @auth_type == 'token'
    end

    def self.default
      new({
        :username   => ENV['LXCA_USERNAME'],
        :password   => ENV['LXCA_PASSWORD'],
        :host       => ENV['LXCA_HOST'],
        :port       => ENV['LXCA_PORT'],
        :verify_ssl => ENV['LXCA_VERIFY_SSL'] != "NONE"
      })
    end

    def is_valid_port(param)
      param = param.to_s
      /^([0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$/.match(param) != nil
    end
  end
end
