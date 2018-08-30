module XClarityClient
  class Configuration

    attr_accessor :username, :password, :host, :auth_type, :port, :verify_ssl,
                  :user_agent_label, :timeout

    HEADER_MESSAGE = 'XClarityClient::Configuration initialize'.freeze

    def initialize(args)
      args.each { |key, value| send("#{key}=", value) }
      validate_required_params
      validate_auth_type
      validate_port
      validate_timeout

      $lxca_log.info(HEADER_MESSAGE, 'Configuration built successfully')
    end

    def validate_port
      msg = 'The port number and host must be valid'
      raise_exception(msg) unless valid_port?(port) || !host.empty?
    end

    def validate_timeout
      msg = 'the timeout must be in seconds and an Integer'
      raise_exception(msg) unless timeout.kind_of?(Integer) || timeout.nil?
    end

    def validate_required_params
      required_params = [username, password, host, port, verify_ssl]
      msg = 'The follow params: username, password, host, port and ' \
            'verify_ssl must all be specified'
      raise_exception(msg) if required_params.any?(&:nil?)
    end

    def validate_auth_type
      msg = 'The auth_type must be a String'
      raise_exception(msg) unless auth_type.kind_of?(String)
      self.auth_type = 'basic_auth' if auth_type.strip.empty?
    end

    def self.default
      data = {
        :username   => ENV['LXCA_USERNAME'],
        :password   => ENV['LXCA_PASSWORD'],
        :host       => ENV['LXCA_HOST'],
        :port       => ENV['LXCA_PORT'],
        :verify_ssl => ENV['LXCA_VERIFY_SSL'] != 'NONE'
      }
      new(data)
    end

    private

    def valid_port?(param)
      param = param.to_s
      expression = '^([0-9]{1,4}|[1-5][0-9]{4}|6[0-4][0-9]{3}' \
                   '|65[0-4][0-9]{2}|655[0-2][0-9]|6553[0-5])$'
      !/#{expression}/.match(param).nil?
    end

    def raise_exception(message)
      $lxca_log.error(HEADER_MESSAGE, message)
      raise(ArgumentError, message)
    end
  end
end
