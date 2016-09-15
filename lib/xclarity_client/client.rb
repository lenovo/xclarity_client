module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_cmms
      CmmManagement.new(@connection).population
    end

    def fetch_cmm(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
      array_cmms = CmmManagement.new(@connection)
      .get_object_cmms(uuids, includeAttributes, excludeAttributes)
    end

  end
end
