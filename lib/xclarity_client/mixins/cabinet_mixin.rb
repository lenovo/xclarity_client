module XClarityClient
  #
  # Exposes CabinetManagement features
  #
  module Mixins::CabinetMixin
    def discover_cabinet(opts = {})
      CabinetManagement.new(@config).fetch_all(opts)
    end

    def fetch_cabinet(uuids = nil,
                      include_attributes = nil,
                      exclude_attributes = nil)
      CabinetManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
