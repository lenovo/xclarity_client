module XClarityClient
  class FanMux < Endpoints::XclarityEndpoint
    BASE_URI = '/fanMuxes'.freeze
    LIST_NAME = 'fanMuxList'.freeze

    attr_accessor :cmmDisplayName, :cmmHealthState, :dataHandle, :description, :FRU, :fruSerialNumber, :hardwareRevision,
                  :leds, :machineType, :manufactureDate, :manufacturer, :manufacturerId, :model, :name, :parent, :partNumber, :productId,
                  :productName, :serialNumber, :slots, :status, :type, :uri, :uuid
  end
end
