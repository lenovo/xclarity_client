module XClarityClient
  #
  # Exposes SwitchManagement features
  #
  module Mixins::SwitchMixin
    def discover_switches(opts = {})
      SwitchManagement.new(@config).fetch_all(opts)
    end

    def fetch_switches(uuids = nil,
                       include_attributes = nil,
                       exclude_attributes = nil)
      SwitchManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
