require 'xclarity_client/services/mixins/list_name_interpreter_mixin'

module XClarityClient
  module Services
    #
    # A response builder knows how to treat a response from LXCA
    # and create a ruby response
    #
    module ResponseBuilderMixin
      include ListNameInterpreterMixin

      #
      # Builds an array from an LXCA response that contains
      # a list of resources.
      #
      # @param response       - the LXCA response
      # @param endpoint_class - the class that represents the endpoint that generates the response
      #
      # @return [Array] containing the resources of the LXCA response
      #
      def build_response_with_resource_list(response, endpoint_class)
        return [] unless response.success?

        body = JSON.parse(response.body)

        if endpoint_class == XClarityClient::User
          body = body['response']
        end

        list_name, body = add_listname_on_body(endpoint_class, body)

        body[list_name].map do |resource_params|
          endpoint_class.new resource_params
        end
      end
    end
  end
end
