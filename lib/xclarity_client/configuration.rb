require 'securerandom'

module XClarityClient
  class Configuration

    attr_accessor :username, :password, :host, :csrf_token, :auth_type, :generated_token

    def initialize(args)
      args.each { |key, value| send("#{key}=", value) }

      unless username && password && host && auth_type && auth_type
        raise ArgumentError, "username, password, and host must all be specified"
      end

      unless (auth_type != 'token' or auth_type != 'basic_auth')
        raise ArgumentError, "auth_type must have 'token' or 'basic_auth' as value"
      end

      @csrf_token ||= SecureRandom.base64(120) unless auth_type != 'token'
    end
  end
end
