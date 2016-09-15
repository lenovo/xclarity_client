module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      Node.new(@connection).populate
    end

    def discover_switches
      SwitchManagement.new(@connection).population
    end

    def fetch_switches(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_switches = SwitchManagement.new(@connection)
      .get_object_switches(uuids, includeAttributes, excludeAttributes)
    end

  end
end
