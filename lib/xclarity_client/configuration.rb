require 'securerandom'

module XClarityClient
  class Configuration

    attr_accessor :username, :password, :host, :csrf_token, :auth_type, :generated_token

    def initialize(args)

      unless username && password && host
        raise ArgumentError, "username, password, and host must all be specified"
      end

      if auth_type.nil?
        auth_type = 'basic_auth'
      end

      args.each { |key, value| send("#{key}=", value) }

      @csrf_token ||= SecureRandom.base64(120) unless auth_type != 'token'
    end
  end
end
