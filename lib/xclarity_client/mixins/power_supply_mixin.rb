module XClarityClient
  #
  # Exposes PowerSupplyManagement features
  #
  module Mixins::PowerSupplyMixin
    def discover_power_supplies(opts = {})
      PowerSupplyManagement.new(@config).fetch_all(opts)
    end

    def fetch_power_supplies(uuids = nil,
                             include_attributes = nil,
                             exclude_attributes = nil)
      PowerSupplyManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
