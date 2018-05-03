module XClarityClient
  #
  # Exposes FanMuxManagement features
  #
  module Mixins::FanMuxMixin
    def discover_fan_muxes(opts = {})
      FanMuxManagement.new(@config).fetch_all(opts)
    end

    def fetch_fan_muxes(uuids = nil,
                        include_attributes = nil,
                        exclude_attributes = nil)
      FanMuxManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
