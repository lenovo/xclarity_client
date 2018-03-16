module XClarityClient
  class ScalableComplex < Endpoints::XclarityEndpoint
    BASE_URI = '/scalableComplex'.freeze
    LIST_NAME = ['complex', 'complexList'].map { |name| name.freeze }.freeze

    attr_accessor :complexID, :location, :nodeCount, :orphanNodes,
                  :partition, :partitionCount, :uuid
  end
end
