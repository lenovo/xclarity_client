module XClarityClient
  #
  # Exposes ChassiManagement features
  #
  module Mixins::ChassiMixin
    def discover_chassis(opts = {})
      ChassiManagement.new(@config).fetch_all(opts)
    end

    def fetch_chassis(uuids = nil,
                      include_attributes = nil,
                      exclude_attributes = nil)
      ChassiManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
