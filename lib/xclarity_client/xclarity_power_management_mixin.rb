# Top Level Xclarity module
module XClarityClient
  # Power management mixin
  module PowerManagementMixin
    def power_on_node(uuid = '')
      node_management.set_node_power_state(uuid, :powerOn)
    end

    def power_off_node(uuid = '')
      node_management.set_node_power_state(uuid, :powerOffSoftGraceful)
    end

    def power_off_node_now(uuid = '')
      node_management.set_node_power_state(uuid, :powerOff)
    end

    def power_restart_node(uuid = '')
      node_management.set_node_power_state(uuid, :powerCycleSoftGrace)
    end

    def power_restart_node_now(uuid = '')
      node_management.set_node_power_state(uuid, :powerCycleSoft)
    end

    def power_restart_node_controller(uuid = '')
      node_management.set_bmc_power_state(uuid, :restart)
    end

    def power_restart_node_to_setup(uuid = '')
      node_management.set_node_power_state(uuid, :bootToF1)
    end

    private

    def node_management
      NodeManagement.new(@config)
    end
  end
end
