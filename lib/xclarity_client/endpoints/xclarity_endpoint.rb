module XClarityClient
  module Endpoints
    class XclarityEndpoint
      include Resource

      def initialize(attributes)
        build_resource(attributes)
      end
    end
  end
end
