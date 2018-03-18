require 'xclarity_client/endpoints/xclarity_endpoint'

module XClarityClient
  module Services
    #
    # An Endpoint Manager must regist what endpoint it is managing
    # to do that, just need to call #manages_endpoint method and
    # pass as param the class that represents the endpoint (must be
    # a subclass of XClarityEndpoint).
    #
    # @see XClarityClient::Endpoints::XClarityEndpoint
    #
    module EndpointManagerMixin

      private

      #
      # Sets which endpoint is managed by the service
      #
      # @param [Class] - Class that represents some endpoind
      # @see XClarityClient::Endpoints::XClarityEndpoint
      #
      def manages_endpoint(endpoint_class)
        raise ArgumentError, "The class #{endpoint_class.name} isn't a subclass of XClarityEndpoint" unless endpoint_class < Endpoints::XclarityEndpoint

        define_method(:managed_resource) { endpoint_class }
      end
    end
  end
end
