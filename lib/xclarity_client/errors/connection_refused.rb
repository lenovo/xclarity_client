module XClarityClient
  module Error
    class ConnectionRefused < StandardError
      def initialize(msg = nil)
        msg = msg.nil? ? 'Connection refused, invalid host.' : msg
        super(msg)
      end
    end
  end
end
