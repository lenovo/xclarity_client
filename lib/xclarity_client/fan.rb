module XClarityClient
  class Fan
    include XClarityClient::Resource

    BASE_URI = '/fans'.freeze

    attr_accessor :cmmDisplayName, :cmmHealthState, :dataHandle, :firmware, :FRU,
    :fruSerialNumber, :hardwareRevision, :manufacturer, :manufacturerId,
    :name, :parent, :partNumber, :posID, :powerState, :uri, :uuid, :vpdID, :description,
    :errorFields,:leds,:machineType,:manufactureDate, :model, :powerAllocation,
    :productId, :productName, :serialNumber, :slots, :type, :userDescription, :cmmHealthState



    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
