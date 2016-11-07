module XClarityClient
  class PowerSupply
    include XClarityClient::Resource

    BASE_URI = '/powerSupplies'.freeze
    LIST_NAME = 'powerSupplyList'.freeze

    attr_accessor :properties, :_id, :cmmDisplayName, :cmmHealthState, :dataHandle,
    :description, :firmware, :FRU, :fruSerialNumber, :hardwareRevision, :inputVoltageMax,
    :inputVoltageIsAC, :inputVoltageMin, :leds, :machineType, :manufacturer, :manufacturerId,
    :manufactureDate, :model, :name, :parent, :powerAllocation, :partNumber, :posID,
    :powerState, :productId, :productName, :serialNumber, :slots, :type, :uri,
    :userDescription, :uuid, :vpdID, :description

    def initialize(attributes)
      build_resource(attributes)
    end
  end
end
