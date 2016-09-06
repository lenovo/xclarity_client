module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      Node.new(@connection).population
    end

    def fetch_nodes(uuids)
      array_nodes = Node.new(@connection).get_object_nodes(uuids)
    end

  end
end
