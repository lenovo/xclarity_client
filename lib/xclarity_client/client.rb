module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      NodeManagement.new(@connection).population
    end

    def discover_scalableComplexes
      ScalableComplexManagement.new(@connection).population
    end

    def discover_cabinet
      CabinetManagement.new(@connection).population
    end

    def fetch_cabinet(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      CabinetManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Cabinet)
    end

    def discover_canisters
      CanisterManagement.new(@connection).population
    end

    def fetch_canisters(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      CanisterManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Canister)
    end

    def discover_cmms
      CmmManagement.new(@connection).population
    end

    def fetch_cmms(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      CmmManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Cmm)
    end

    def fetch_fans(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      FanManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, Fan)
    end

    def discover_fans
      FanManagement.new(@connection).population
    end

    def discover_switches
      SwitchManagement.new(@connection).population
    end

    def discover_fan_muxes
      FanMuxManagement.new(@connection).population
    end

    def fetch_fan_muxes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      FanMuxManagement.new(@connection).get_object(uuids, includeAttributes, excludeAttributes, FanMux)
    end

    def discover_chassis
      ChassiManagement.new(@connection).population
    end

    def discover_power_supplies
      PowerSupplyManagement.new(@connection).population
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

    def discover_events
      EventManagement.new(@connection).population
    end

    def fetch_events(opts = {})
      EventManagement.new(@connection).get_object_with_opts(opts, Event)
    end
  end
end
