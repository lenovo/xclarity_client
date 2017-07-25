# Top Level Xclarity module
module XClarityClient
  # Power management mixin
  module PowerManagementMixin
    def power_on_node(uuid = '')
      NodeManagement.new(@connection).set_node_power_state(uuid, :powerOn)
    end

    def power_off_node(uuid = '')
      NodeManagement.new(@connection).set_node_power_state(uuid, :powerOff)
    end

    def power_off_node_now(uuid = '')
      NodeManagement.new(@connection).set_node_power_state(uuid, :powerNMI)
    end

    def power_restart_node(uuid = '')
      client = NodeManagement.new(@connection)
      client.set_node_power_state(uuid, :powerCycleSoftGrace)
    end

    def power_restart_node_now(uuid = '')
      client = NodeManagement.new(@connection)
      client.set_node_power_state(uuid, :powerCycleSoft)
    end

    def power_restart_node_controller(uuid = '')
      client = NodeManagement.new(@connection)
      client.set_bmc_power_state(uuid, :restart)
    end

    def power_restart_node_to_setup(uuid = '')
      NodeManagement.new(@connection).set_node_power_state(uuid, :bootToF1)
    end
  end
end
