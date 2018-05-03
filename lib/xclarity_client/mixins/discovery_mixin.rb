module XClarityClient
  #
  # Exposes DiscoveryManagement features
  #
  module Mixins::DiscoverMixin
    def discover_devices_by_slp
      DiscoveryManagement.new(@config).fetch_all
    end
  end
end
