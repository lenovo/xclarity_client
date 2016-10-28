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
        begin
          send("#{key}=", value)
        rescue
          $log.warn("UNEXISTING ATTRIBUTES FOR SCALABLE_COMPLEX: #{key}") unless Rails.nil?
        end
      end
    end

  end
end
