module XClarityClient
  #
  # Exposes ScalableComplexManagement features
  #
  module Mixins::ScalableComplexMixin
    def discover_scalableComplexes(opts = {})
      ScalableComplexManagement.new(@config).fetch_all(opts)
    end

    def fetch_scalableComplexes(uuids = nil,
                                include_attributes = nil,
                                exclude_attributes = nil)
      ScalableComplexManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
