module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      Node.new(@connection).populate
    end

    def discover_fan_muxes
      FanMuxManagement.new(@connection).population
    end

    def fetch_fan_muxes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_nodes = FanMuxManagement.new(@connection)
      .get_object_fan_muxes(uuids, includeAttributes, excludeAttributes)
    end

  end
end
