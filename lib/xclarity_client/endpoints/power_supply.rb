module XClarityClient
  class PowerSupply < Endpoints::XclarityEndpoint
    BASE_URI = '/powerSupplies'.freeze
    LIST_NAME = 'powerSupplyList'.freeze

    attr_accessor :cmmDisplayName, :cmmHealthState, :dataHandle, :description, :firmware, :FRU, :fruSerialNumber, :hardwareRevision,
                  :inputVoltageIsAC, :inputVoltageMax, :inputVoltageMin, :leds, :machineType, :manufactureDate, :manufacturer,
                  :manufacturerId, :model, :name, :parent, :partNumber, :posID, :powerAllocation, :powerState, :productId, :productName,
                  :serialNumber, :slots, :type, :uri, :userDescription, :uuid, :vpdID
  end
end
