module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      NodeManagement.new(@connection).population
    end

    def fetch_nodes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_nodes = NodeManagement.new(@connection)
      .get_object_nodes(uuids, includeAttributes, excludeAttributes)
    end

    def discover_canisters
      CanisterManagement.new(@connection).population
    end

    def fetch_canisters(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_nodes = CanisterManagement.new(@connection)
      .get_object_canisters(uuids, includeAttributes, excludeAttributes)
    end

  end
end
