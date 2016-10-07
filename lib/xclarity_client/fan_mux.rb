module XClarityClient
  class FanMux

    BASE_URI = '/fan_muxes'.freeze

    attr_accessor :cmmDisplayName, :cmmHealthState, :dataHandle, :description, :FRU,
      :fruSerialNumber, :hardwareRevision, :leds, :machineType, :manufacturer, :manufactureDate,
      :manufacturerId, :model, :name, :parent, :partNumber, :productId, :productName, :serialNumber,
      :slots, :status, :type, :uri, :uuid


    def initialize(attributes)
      build_fan_mux(attributes)
    end

    def build_fan_mux(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

  end
end
