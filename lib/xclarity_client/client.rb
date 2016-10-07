module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_cabinet
      CabinetManagement.new(@connection).population
    end

    def fetch_cabinet(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_cabinet = CabinetManagement.new(@connection)
      .get_object_cabinet(uuids, includeAttributes, excludeAttributes)
    end

  end
end
