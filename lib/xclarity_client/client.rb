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

    def discover_switches
      SwitchManagement.new(@connection).population
    end

    def fetch_nodes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_nodes = NodeManagement.new(@connection)
      .get_object_nodes(uuids, includeAttributes, excludeAttributes)
    end


    def fetch_scalableComplexes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_scalableComplexes = ScalableComplexManagement.new(@connection)
      .get_object_scalableComplexes(uuids, includeAttributes, excludeAttributes)
    end



    def fetch_switches(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_switches = SwitchManagement.new(@connection)
      .get_object_switches(uuids, includeAttributes, excludeAttributes)
    end

  end
end
