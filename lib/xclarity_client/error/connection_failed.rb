module XClarityClient
  module Error
    class ConnectionFailed < StandardError
      def initialize(msg = nil)
        msg = msg.nil? ? 'Execution expired or invalid port.' : msg
        super(msg)
      end
    end
  end
end
