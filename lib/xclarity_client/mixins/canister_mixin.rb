module XClarityClient
  #
  # Exposes CanisterManagement features
  #
  module Mixins::CanisterMixin
    def discover_canisters(opts = {})
      CanisterManagement.new(@config).fetch_all(opts)
    end

    def fetch_canisters(uuids = nil,
                        include_attributes = nil,
                        exclude_attributes = nil)
      CanisterManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
