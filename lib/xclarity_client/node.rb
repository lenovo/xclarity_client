module XClarityClient
  class Node

    BASE_URI = '/nodes'.freeze

    attr_accessor :accessState, :activationKeys, :uuid, :addinCardSlots, :addinCards, :vnicMode, :productName, :arch, :backedBy, :bladeState, :bootMode,
      :bootOrder, :canisters, :canisterSlots, :cmmDisplayName, :cmmHealthState, :complexID, :dataHandle, :dnsHostnames, :domainName,
      :driveBays, :embeddedHypervisorPresence, :errorFields, :excludedHealthState, :expansionCardSlots, :expansionCards,
      :expansionProductType, :expansionProducts, :expansionProductSlots, :firmware, :flashStorage, :fruSerialNumber, :hostMacAddresses, :hostname, :ipInterfaces,
      :ipv4Addresses, :ipv6Addresses, :isConnectionTrusted, :isITME, :hasOS, :isRemotePresenceEnabled, :isScalable, :lanOverUsb,
      :machineType, :manufacturer, :manufacturerID ,:memoryModules,:memorySlots, :mgmtProcIPaddress, :model, :nist, :onboardPciDevices,
      :overallHealthState, :partitionEnabled, :powerStatus, :pciExpressCards, :pciExpressCardSlots, :physicalID, :ports, :posID, :powerAllocation, :powerCappingPolicy,
      :powerSupplies, :primary, :processorSlots, :processors, :productID, :raidSettings, :secureBootMode, :serialNumber, :slots, :status, :subSlots,
      :thinkServerFru, :tlsVersion, :type, :uri ,:userDescription ,:vpdID,:contact, :description, :driveBays, :drives,:encapsulation, :FRU,:height,:leds,:location,:logicalID,
      :macAddress,:name,:parent,:parentComplexID, :parentPartitionUUID,:partNumber,:partitionEnabled,:partitionID,:pciCapabilities,:pciDevices,:subType


    def initialize(attributes)
      build_node(attributes)
    end

    def build_node(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

  end
end
