module XClarityClient
  #
  # This class defines an endpoint for a Storage
  #
  # A Storage is a physical system capable of store a large amount of data with
  # speed, security and high availability
  #
  class Storage < Endpoints::XclarityEndpoint
    BASE_URI = '/storages'.freeze
    LIST_NAME = 'storageList'.freeze

    attr_accessor :uuid, :name, :type, :accessState, :cmmHealthState,
                  :overallHealthState, :driveBays, :enclosureCount,
                  :canisterSlots, :productName, :machineType, :model,
                  :serialNumber, :contact, :description, :location,
                  :room, :rack, :lowestRackUnit, :mgmtProcIPaddress
  end
end
