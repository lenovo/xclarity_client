module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      NodeManagement.new(@connection).population
    end

    def discover_fans
      FanManagement.new(@connection).population
    end

    def fetch_nodes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_nodes = NodeManagement.new(@connection)
      .get_object_nodes(uuids, includeAttributes, excludeAttributes)
    end

    def fetch_fans(uuids = nil, includeAttributes = nil, excludeAttributes = nil)

      array_fans = FanManagement.new(@connection)
      .get_object_fans(uuids, includeAttributes, excludeAttributes)
    end

  end
end
