module XClarityClient
  class Node
    include XClarityClient::Resource

    BASE_URI = '/nodes'.freeze

    attr_accessor :properties,:_uuid, :accessState, :activationKeys, :uuid, :addinCardSlots, :addinCards, :vnicMode, :productName, :arch, :backedBy, :bladeState_health, :bootMode,
      :bootOrder, :canisters, :canisterSlots, :cmmDisplayName, :cmmHealthState, :complexID, :dataHandle, :dnsHostnames, :domainName, :bladeState, :bladeState_string,
      :driveBays, :embeddedHypervisorPresence, :errorFields, :excludedHealthState, :expansionCardSlots, :expansionCards, :lanOverUsbPortForwardingModes,
      :expansionProductType, :expansionProducts, :expansionProductSlots, :firmware, :flashStorage, :fruSerialNumber, :hostMacAddresses, :hostname, :ipInterfaces,
      :ipv4Addresses, :ipv6Addresses, :isConnectionTrusted, :isITME, :hasOS, :isRemotePresenceEnabled, :isScalable, :lanOverUsb,
      :machineType, :manufacturer, :manufacturerId ,:memoryModules,:memorySlots, :mgmtProcIPaddress, :model, :nist, :onboardPciDevices,
      :overallHealthState, :partitionEnabled, :powerStatus, :pciExpressCards, :pciExpressCardSlots, :physicalID, :ports, :posID, :powerAllocation, :powerCappingPolicy,
      :powerSupplies, :primary, :processorSlots, :processors, :productId, :raidSettings, :secureBootMode, :serialNumber, :slots, :status, :subSlots,
      :thinkServerFru, :tlsVersion, :type, :uri ,:userDescription ,:vpdID,:contact, :description, :driveBays, :drives,:encapsulation, :FRU,:height,:leds,:location,:logicalID,
      :macAddress,:name,:parent,:parentComplexID, :parentPartitionUUID,:partNumber,:partitionEnabled,:partitionID,:pciCapabilities,:pciDevices,:subType, :fans, :fruNumber,
      :password, :recoveryPassword, :username, :managementPorts, :displayName, :ipAddresses


    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
