module XClarityClient
  module Error
    class ConnectionFailedUnknown < StandardError
      def initialize(msg)
        msg = "Connection failed, #{msg.nil? ? 'reason unknown' : msg}."
        super(msg)
      end
    end
  end
end
