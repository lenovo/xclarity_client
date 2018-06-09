module XClarityClient
  #
  # Exposes CmmManagement features
  #
  module Mixins::CmmMixin
    def discover_cmms(opts = {})
      CmmManagement.new(@config).fetch_all(opts)
    end

    def fetch_cmms(uuids = nil,
                   include_attributes = nil,
                   exclude_attributes = nil)
      CmmManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
