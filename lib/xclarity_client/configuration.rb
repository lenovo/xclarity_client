require 'securerandom'

module XClarityClient
  class Configuration

    attr_accessor :username, :password, :host, :csrf_token, :auth_type, :generated_token, :verify_ssl

    def initialize(args)

      args.each { |key, value| send("#{key}=", value) }

      if [username, password, host, verify_ssl].any? { |item| item.nil? }
        raise ArgumentError, "username, password, host, and verify_ssl must all be specified"
      end

      if auth_type.nil?
        auth_type = 'basic_auth'
      end

      @csrf_token ||= SecureRandom.base64(120) unless auth_type != 'token'
    end
  end
end
