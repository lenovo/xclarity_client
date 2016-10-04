module XClarityClient
  class Canister

    BASE_URI = '/canisters'.freeze

    attr_accessor :cmmDisplayName, :backedBy, :contact, :dataHandle,  :description,
      :firmware, :FRU, :domainName, :driveBays, :drives, :errorFields, :ipInterfaces, :powerStatus,
      :fruSerialNumber, :manufacturer, :manufacturerId, :processorSlots,
      :processors, :name, :parent, :posID, :productId, :productName, :type,
      :serviceHostName, :userDescription, :uri, :vnicMode, :uuid, :vpdID, :activationKeys, :bladeState, :cmmHealthState,
      :hostname, :ipv4Addresses, :ipv4ServiceAddress,:ipv6Addresses, :ipv6ServiceAddress, :lanOverUsb, :leds, :location,
      :macAddress, :machineType, :memoryModules, :memorySlots, :model, :partNumber, :posId,:serialNumber,:slots, :subType,
      :subSlots

    def initialize(attributes)
      build_canister(attributes)
    end

    def build_canister(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

  end
end
