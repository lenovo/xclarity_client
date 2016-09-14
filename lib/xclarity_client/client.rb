module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      Node.new(@connection).populate
    end

  end
end
 
