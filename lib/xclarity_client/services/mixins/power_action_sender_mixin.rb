module XClarityClient
  module Services
    #
    # A Power Action Sender is capable to send power
    # operation request for its managed endpoint.
    #
    module PowerActionSenderMixin
      #
      # Changes the power state for some resource.
      #
      # @param [String] uuid  - resource identifier
      # @param [symbol] state - the new power state
      #   it must be listed on `managed_resource::POWER_ACTIONS`
      #
      # @return the LXCA response.
      #
      def set_power_state(uuid, state)
        unless valid_arguments?(uuid, state)
          error = 'Invalid target or power state requested'
          source = "#{self.class.name} set_power_state"
          $lxca_log.info(source, error)
          raise ArgumentError, error
        end

        send_power_request(managed_resource::BASE_URI + '/' + uuid, state)
      end

      #
      # Do a change power state request for an endpoint
      #
      # @param [String] uri - the URI of the endpoint that must
      #   have its power state changed.
      # @param [symbol] requested_state - the new power state.
      #
      # @return the LXCA response.
      #
      def send_power_request(uri, requested_state = nil)
        power_request = JSON.generate(:powerState => requested_state)
        response = @connection.do_put(uri, power_request)
        msg = "Power state action has been sent with request #{power_request}"

        $lxca_log.info("#{self.class.name} send_power_request", msg)
        response
      end

      private

      #
      # Validates the power operations arguments.
      #   Verifies if the uuid is not blank
      #   Verifies if the endpoint supports the new state
      #
      def valid_arguments?(uuid, state)
        uuid ||= ''
        !uuid.empty? && managed_resource::POWER_ACTIONS.include?(state)
      end
    end
  end
end
