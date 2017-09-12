module XClarityClient
  class Fan
    include XClarityClient::Resource

    BASE_URI = '/fans'.freeze
    LIST_NAME = 'fanList'.freeze

    attr_accessor :cmmDisplayName, :cmmHealthState, :dataHandle, :description,
                  :errorFields, :firmware, :FRU, :fruSerialNumber, :hardwareRevision,
                  :leds, :machineType, :manufactureDate, :manufacturer, :manufacturerId,
                  :model, :name, :parent, :partNumber, :posID, :powerAllocation, :powerState,
                  :productId, :productName, :serialNumber, :slots, :type, :uri, :userDescription,
                  :uuid, :vpdID


    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
