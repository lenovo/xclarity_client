module XClarityClient
  class Canister

    BASE_URI = '/canisters'.freeze

    attr_accessor :cmmDisplayName, :backedBy, :contact, :dataHandle,  :description,
      :firmware, :FRU, :domainName, :driveBays, :drives, :errorFields, :ipInterfaces, :powerStatus,
      :fruSerialNumber, :manufacturer, :manufacturerID, :processorSlots,
      :processors, :name, :parent, :posID, :productId, :productName,
      :serviceHostName, :userDescription, :uri, :vnicMode, :uuid, :vpdID,

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
