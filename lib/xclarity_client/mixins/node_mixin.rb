module XClarityClient
  #
  # Exposes NodeManagement features
  #
  module Mixins::NodeMixin
    def discover_nodes(opts = {})
      NodeManagement.new(@config).fetch_all(opts)
    end

    def fetch_nodes(uuids = nil,
                    include_attributes = nil,
                    exclude_attributes = nil)
      NodeManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end

    def blink_loc_led(uuid = '')
      NodeManagement.new(@config).set_loc_led_state(uuid, 'Blinking')
    end

    def turn_on_loc_led(uuid = '')
      NodeManagement.new(@config).set_loc_led_state(uuid, 'On')
    end

    def turn_off_loc_led(uuid = '')
      NodeManagement.new(@config).set_loc_led_state(uuid, 'Off')
    end
  end
end
