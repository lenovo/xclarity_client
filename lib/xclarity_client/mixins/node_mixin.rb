module XClarityClient
  #
  # Exposes NodeManagement features
  #
  module Mixins::NodeMixin
    def discover_nodes(opts = {})
      node_management.fetch_all(opts)
    end

    def fetch_nodes(uuids = nil,
                    include_attributes = nil,
                    exclude_attributes = nil)
      node_management.get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end

    def blink_loc_led(uuid = '', name = 'Identify')
      node_management.set_loc_led_state(uuid, 'Blinking', name)
    end

    def turn_on_loc_led(uuid = '', name = 'Identify')
      node_management.set_loc_led_state(uuid, 'On', name)
    end

    def turn_off_loc_led(uuid = '', name = 'Identify')
      node_management.set_loc_led_state(uuid, 'Off', name)
    end

    def power_on_node(uuid = '')
      node_management.set_power_state(uuid, :powerOn)
    end

    def power_off_node(uuid = '')
      node_management.set_power_state(uuid, :powerOffSoftGraceful)
    end

    def power_off_node_now(uuid = '')
      node_management.set_power_state(uuid, :powerOff)
    end

    def power_restart_node(uuid = '')
      node_management.set_power_state(uuid, :powerCycleSoftGrace)
    end

    def power_restart_node_now(uuid = '')
      node_management.set_power_state(uuid, :powerCycleSoft)
    end

    def power_restart_node_controller(uuid = '')
      node_management.set_bmc_power_state(uuid, :restart)
    end

    def power_restart_node_to_setup(uuid = '')
      node_management.set_power_state(uuid, :bootToF1)
    end

    private

    def node_management
      NodeManagement.new(@config)
    end
  end
end
