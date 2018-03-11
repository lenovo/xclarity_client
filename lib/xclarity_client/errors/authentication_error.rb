module XClarityClient
  module Error
    class AuthenticationError < StandardError
      def initialize(msg = nil)
        msg = msg.nil? ? 'Invalid credentials for this host.' : msg
        super(msg)
      end
    end
  end
end
