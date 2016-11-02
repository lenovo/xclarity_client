module XClarityClient
  class FanMux
    include XClarityClient::Resource

    BASE_URI = '/fan_muxes'.freeze

    attr_accessor :cmmDisplayName, :cmmHealthState, :dataHandle, :description, :FRU,
      :fruSerialNumber, :hardwareRevision, :leds, :machineType, :manufacturer, :manufactureDate,
      :manufacturerId, :model, :name, :parent, :partNumber, :productId, :productName, :serialNumber,
      :slots, :status, :type, :uri, :uuid


    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
