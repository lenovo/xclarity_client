require 'xclarity_client/endpoints/buildable_resource_mixin'

module XClarityClient
  module Endpoints
    class XclarityEndpoint
      include BuildableResourceMixin

      def initialize(attributes)
        build_resource!(attributes)
      end
    end
  end
end
