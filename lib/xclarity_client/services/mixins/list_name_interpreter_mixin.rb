module XClarityClient
  module Services
    #
    # A list name interpreter knows how to get the correct
    # list name present on endpoint response, and, if the list
    # doesn't exist, add the list property to the reponse with
    # the right name.
    #
    module ListNameInterpreterMixin
      #
      # Process the response body to make sure that its contains the list name defined on resource
      #
      # @return the list name present on body and the body itself
      #
      def add_listname_on_body(endpoint_class, body)
        body.kind_of?(Array) ? process_body_as_array(endpoint_class, body) : process_body_as_hash(endpoint_class, body)
      end

      private

      #
      # @return any listname described on resource
      #
      def any_listname_of(endpoint_class)
        if endpoint_class::LIST_NAME.kind_of?(Array)
          endpoint_class::LIST_NAME.first # If is an array, any listname can be use
        else
          endpoint_class::LIST_NAME # If is not an array, just return the listname of resource
        end
      end

      #
      # @return the body value assigned to the list name defined on resource
      #
      def process_body_as_array(endpoint_class, body)
        list_name = any_listname_of(endpoint_class)

        return list_name, { list_name => body } # assign the list name to the body
      end

      #
      # Discover what list name defined on resource is present on body
      # If none of then is find assume that the body is a single resource
      # and add it value into array and assing to any list name
      #
      # @return the list name present on body and the body itself
      #
      def process_body_as_hash(endpoint_class, body)
        result = body

        if endpoint_class::LIST_NAME.kind_of? Array # search which list name is present on body
          list_name = endpoint_class::LIST_NAME.find { |name| body.keys.include?(name) && body[name].kind_of?(Array) }
        else
          list_name = any_listname_of(endpoint_class)
        end
        result = {list_name => [body]} unless body.has_key? list_name # for the cases where body represents a single resource
        return list_name, result
      end
    end
  end
end