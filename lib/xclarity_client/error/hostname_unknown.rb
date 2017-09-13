module XClarityClient
  module Error
    class HostnameUnknown < StandardError
      def initialize(msg = nil)
        msg = msg.nil? ? 'Connection failed, hostname unknown.' : msg
        super(msg)
      end
    end
  end
end
