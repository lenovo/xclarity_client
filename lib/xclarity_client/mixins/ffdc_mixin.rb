module XClarityClient
  #
  # Exposes FfdcManagement features
  #
  module Mixins::FfdcMixin
    def fetch_ffdc(uuids = nil,
                   include_attributes = nil,
                   exclude_attributes = nil)
      FfdcManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
