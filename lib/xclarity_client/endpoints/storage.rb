module XClarityClient
  #
  # This class defines an endpoint for a Storage
  #
  # A Storage is a physical system capable of store a large amount of data with
  # speed, security and high availability
  #
  class Storage < Endpoints::XclarityEndpoint
    BASE_URI = '/storage'.freeze
    LIST_NAME = 'storageList'.freeze

    attr_accessor :uuid, :name, :type, :accessState, :cmmHealthState,
                  :enclosures, :canisters, :overallHealthState, :driveBays,
                  :enclosureCount, :canisterSlots, :parent,
                  :productName, :machineType, :model,
                  :serialNumber, :contact, :description,
                  :location, :room, :rack, :lowestRackUnit,
                  :mgmtProcIPaddress
  end
end
