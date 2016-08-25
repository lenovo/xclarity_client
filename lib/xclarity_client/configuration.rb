module XClarityClient
  class Configuration

    attr_accessor :username, :password, :host

    def initialize(args)
      args.each { |key, value| send("#{key}=", value) }

      unless username && password && host
        raise ArgumentError, "username, password, and host must all be specified"
      end
    end
  end
end
