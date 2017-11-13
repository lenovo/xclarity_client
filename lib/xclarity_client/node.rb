module XClarityClient
  class Node
    include XClarityClient::Resource

    BASE_URI = '/nodes'.freeze
    LIST_NAME = 'nodeList'.freeze

    attr_accessor :accessState, :activationKeys, :addinCards, :addinCardSlots, :arch, :backedBy, :bladeState, :bladeState_health,
                  :bladeState_string, :bootMode, :bootOrder, :cmmDisplayName, :cmmHealthState, :complexID, :contact, :dataHandle,
                  :description, :displayName, :dnsHostnames, :domainName, :driveBays, :drives, :embeddedHypervisorPresence, :encapsulation,
                  :enclosure_form_factor, :errorFields, :excludedHealthState, :expansionCards, :expansionCardSlots, :expansionProducts,
                  :expansionProductType, :faceplateIDs, :fans, :firmware, :flashStorage, :FQDN, :FRU, :fruNumber, :fruSerialNumber, :hasOS, :height,
                  :hostMacAddresses, :hostname, :ipAddresses, :ipInterfaces, :ipv4Addresses, :ipv6Addresses, :isConnectionTrusted, :isITME, :isRemotePresenceEnabled,
                  :isScalable, :lanOverUsb, :lanOverUsbPortForwardingModes, :leds, :location, :m2Presence, :macAddress, :machineType, :managementPorts, :manufacturer,
                  :manufacturerId, :memoryModules, :memorySlots, :mgmtProcIPaddress, :mgmtProcType, :model, :name, :nist, :onboardPciDevices, :overallHealthState, :parent,
                  :parentComplexID, :parentPartitionUUID, :partitionEnabled, :partitionID, :partNumber, :password, :pciCapabilities, :pciDevices, :physicalID, :ports,
                  :posID, :powerAllocation, :powerCappingPolicy, :powerStatus, :powerSupplies, :processors, :processorSlots, :productId, :productName, :raidSettings,
                  :recoveryPassword, :secureBootMode, :serialNumber, :server_type, :slots, :status, :subSlots, :subType, :thinkServerFru, :tlsVersion, :type, :uri,
                  :userDescription, :username, :uuid, :vnicMode, :vpdID, :securityDescriptor, :primary, :logicalID, :FeaturesOnDemand,
                  :canisterSlots, :canisters

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
