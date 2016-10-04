module XClarityClient
  class ScalableComplex

    BASE_URI = '/scalable_complexes'.freeze

    attr_accessor :properties, :_id, :location, :nodeCount, :orphanNodes,
    :partition, :partitionCount, :uuid, :slots, :complexID


    def initialize(attributes)
      build_scalableComplex(attributes)
    end

    def build_scalableComplex(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

  end
end
