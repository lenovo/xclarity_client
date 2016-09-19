module XClarityClient
  class Fan

    BASE_URI = '/fans'.freeze

    attr_accessor :cmmDisplayName, :cmmHealthState, :dataHandle, :firmware, :FRU,
    :fruSerialNumber, :hardwareRevision, :manufacturer, :manufacturerID,
    :name, :parent, :partNumber, :posID, :powerState, :uri, :uuid, :vpdID, :description,
    :errorFields,:leds,:machineType,:manufacturingDate, :model, :powerAllocation,
    :productID, :productName, :serialNumber, :slots, :type, :userDescription



    def initialize(attributes)
      build_fan(attributes)
    end

    def build_fan(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

  end
end
