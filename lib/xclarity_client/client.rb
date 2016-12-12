module XClarityClient

  class Client

    def initialize(connection)
      @connection = connection
    end
    
    def discover_nodes(opts = {})
      NodeManagement.new(@connection).population opts
    end
        
    def power_on_node(uuid = '')
        NodeManagement.new(@connection).set_node_power_state(uuid, "powerOn")
    end

    def power_off_node(uuid = '')
        NodeManagement.new(@connection).set_node_power_state(uuid, "powerOff")
    end

    def power_restart_node(uuid = '')
        NodeManagement.new(@connection).set_node_power_state(uuid, "powerCycleSoftGrace")
    end

    def discover_scalableComplexes(opts = {})
      ScalableComplexManagement.new(@connection).population opts
    end

    def discover_cabinet(opts = {})
      CabinetManagement.new(@connection).population opts
    end

    def fetch_cabinet(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      CabinetManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Cabinet)
    end

    def discover_canisters(opts = {})
      CanisterManagement.new(@connection).population opts
    end

    def fetch_canisters(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      CanisterManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Canister)
    end

    def discover_cmms(opts = {})
      CmmManagement.new(@connection).population opts
    end

    def fetch_cmms(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      CmmManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Cmm)
    end

    def fetch_fans(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      FanManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Fan)
    end

    def discover_fans(opts = {})
      FanManagement.new(@connection).population opts
    end

    def discover_switches(opts = {})
      SwitchManagement.new(@connection).population opts
    end

    def discover_fan_muxes(opts = {})
      FanMuxManagement.new(@connection).population opts
    end

    def fetch_fan_muxes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      FanMuxManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, FanMux)
    end

    def discover_chassis(opts = {})
      ChassiManagement.new(@connection).population opts
    end

    def discover_power_supplies(opts = {})
      PowerSupplyManagement.new(@connection).population opts
    end

    def fetch_nodes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      NodeManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Node)
    end

    def fetch_chassis(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      ChassiManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Chassi)
    end

    def fetch_scalableComplexes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      ScalableComplexManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, ScalableComplex)
    end

    def fetch_switches(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      SwitchManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Switch)
    end

    def fetch_power_supplies(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      PowerSupplyManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, PowerSupply)
    end

    def turn_on_loc_led(uuid = "", enableBlinking = false)
      state = enableBlinking ? "Blinking" : "On"
      NodeManagement.new(@connection).set_loc_led_state(uuid, state)
    end

    def turn_off_loc_led(uuid = "")
      NodeManagement.new(@connection).set_loc_led_state(uuid, "Off")
    end
    
  end
end
