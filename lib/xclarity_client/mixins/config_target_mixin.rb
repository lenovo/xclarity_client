module XClarityClient
  #
  # Exposes ConfigTargetManagement features
  #
  module Mixins::ConfigTargetMixin
    def fetch_config_target(ids = nil,
                            include_attributes = nil,
                            exclude_attributes = nil)
      ConfigTargetManagement.new(@config).get_object_with_id(
        ids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
