module XClarityClient
  #
  # Exposes FanManagement features
  #
  module Mixins::FanMixin
    def fetch_fans(uuids = nil,
                   include_attributes = nil,
                   exclude_attributes = nil)
      FanManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end

    def discover_fans(opts = {})
      FanManagement.new(@config).fetch_all(opts)
    end
  end
end
