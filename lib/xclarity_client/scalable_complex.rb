module XClarityClient
  class ScalableComplex
    include XClarityClient::Resource

    BASE_URI = '/scalableComplex'.freeze
    LIST_NAME = 'complex'.freeze

    attr_accessor :complexID, :location, :nodeCount, :orphanNodes,
                  :partition, :partitionCount, :uuid


    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
