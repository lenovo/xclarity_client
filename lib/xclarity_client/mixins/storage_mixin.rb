module XClarityClient
  #
  # Exposes StorageManagement features
  #
  module Mixins::StorageMixin
    def discover_storages(opts = {})
      StorageManagement.new(@config).fetch_all(opts)
    end

    def fetch_storages(uuids = nil,
                       include_attributes = nil,
                       exclude_attributes = nil)
      StorageManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end
  end
end
