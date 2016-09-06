module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      NodeController.new(@connection).population
    end

    def fetch_nodes(uuids)
      array_nodes = NodeController.new(@connection).get_object_nodes(uuids)
    end

    def fetch_nodes_exclude_attr(uuids, attributes)
      array_nodes = NodeController.new(@connection).get_object_nodes_exclude_attributes(uuids, attributes)
    end

    def fetch_nodes_include_attr(uuids, attributes)
      array_nodes = NodeController.new(@connection).get_object_nodes_include_attributes(uuids, attributes)
    end

  end
end
