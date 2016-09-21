module XClarityClient
  class Client

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes
      Node.new(@connection).populate
    end

    def discover_scalableComplexes
     ScalableComplexManagement.new(@connection).population
   end

   def fetch_scalableComplexes(uuids = nil, includeAttributes = nil, excludeAttributes = nil)
     array_scalable_complexes = ScalableComplexManagement.new(@connection)
     .get_object_scalableComplexes(uuids, includeAttributes, excludeAttributes)
   end

  end
end
