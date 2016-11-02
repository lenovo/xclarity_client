module XClarityClient
  class ScalableComplex
    include XClarityClient::Resource

    BASE_URI = '/scalable_complexes'.freeze

    attr_accessor :properties, :_id, :location, :nodeCount, :orphanNodes,
    :partition, :partitionCount, :uuid, :slots, :complexID


    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
