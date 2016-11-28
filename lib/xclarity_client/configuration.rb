require 'securerandom'

module XClarityClient
  class Configuration

    attr_accessor :username, :password, :host, :csrf_token, :auth_type, :generated_token, :verify_ssl

    def initialize(args)

      args.each { |key, value| send("#{key}=", value) }

      if [username, password, host, verify_ssl].any? { |item| item.nil? }
        raise ArgumentError, "username, password, host, and verify_ssl must all be specified"
      end


      if not @auth_type.is_a?(String) or @auth_type == ''
        @auth_type = 'basic_auth'
      end

      @csrf_token ||= SecureRandom.base64(120) if @auth_type == 'token'
    end

    def self.default
      new({
        :username   => ENV['LXCA_USERNAME'],
        :password   => ENV['LXCA_PASSWORD'],
        :host       => ENV['LXCA_HOST'],
        :verify_ssl => ENV['LXCA_VERIFY_SSL'] != "NONE"
      })
    end
  end
end
