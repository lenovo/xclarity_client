module XClarityClient
  module Services
    #
    # A Power Action Sender is capable to send power
    # operation request for its managed endpoint.
    #
    # An XclarityEndpoint that supports power or LED operations
    # must configure the supported operations through `POWER_ACTIONS` and
    # `LED_STATES` constants.
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
        unless valid_arguments?(uuid, state, managed_resource::POWER_ACTIONS)
          error = 'Invalid target or power state requested'
          source = "#{self.class.name} set_power_state"
          $lxca_log.info(source, error)
          raise ArgumentError, error
        end

        send_power_request(
          "#{managed_resource::BASE_URI}/#{uuid}", state
        )
      end

      #
      # Changes the state of a LED of some resource.
      #
      # @param [String] uuid  - resource identifier
      # @param [String] state - the new LED state
      #   it must be listed on `managed_resource::LED_STATES`
      # @param [String] name  - name of the LED that must have it state changed
      #
      # @return the LXCA response
      #
      def set_loc_led_state(uuid, state, name = 'Identify')
        unless valid_arguments?(uuid, state, managed_resource::LED_STATES)
          error = 'Invalid target or power state requested'
          source = "#{self.class.name} set_loc_led_state"
          $lxca_log.info(source, error)
          raise ArgumentError, error
        end

        send_led_state_request(
          "#{managed_resource::BASE_URI}/#{uuid}", state, name
        )
      end

      #
      # Do a change power state request for an endpoint
      #
      # @param [String] uri
      #  - the URI of the endpoint that must have its power state changed.
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

      #
      # Do a change LED state request for an endpoint
      #
      # @param [String] uri
      #   - The URI that must receive the request.
      # @param [String] requested_state
      #   - The new LED state.
      # @param [String] led_name
      #   - name of the LED that must have it state changed.
      #
      # @return the LXCA response.
      #
      def send_led_state_request(uri,
                                 requested_state = nil,
                                 led_name = 'Identify')
        request = JSON.generate(
          :leds => [{ :name => led_name, :state => requested_state }]
        )
        response = @connection.do_put(uri, request)
        msg = "LED state request has been sent with request #{request}"

        $lxca_log.info("#{self.class.name} send_led_state_request", msg)
        response
      end

      private

      #
      # Validates the power operations arguments.
      #   Verifies if the uuid is not blank
      #   Verifies if the endpoint supports the new state
      #
      def valid_arguments?(uuid, desired_state, allowed_states)
        uuid ||= ''
        !uuid.empty? && allowed_states.include?(desired_state)
      end
    end
  end
end
