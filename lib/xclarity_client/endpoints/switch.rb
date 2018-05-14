module XClarityClient
  class Switch < Endpoints::XclarityEndpoint
    BASE_URI = '/switches'.freeze
    LIST_NAME = 'switchList'.freeze
    POWER_ACTIONS = %i(
      powerCycleSoft
    ).freeze

    attr_accessor :accessState, :attachedNodes, :backedBy, :cmmDisplayName, :cmmHealthState,
                  :dataHandle, :description, :dnsHostnames, :errorFields, :excludedHealthState,
                  :firmware, :FRU, :fruSerialNumber, :hostname, :ipInterfaces, :ipv4Addresses,
                  :ipv6Addresses, :leds, :macAddresses, :machineType, :manufacturer, :manufacturerId,
                  :model, :name, :overallHealthState, :parent, :partNumber, :posID, :powerAllocation,
                  :powerState, :productId, :productName, :protectedMode, :serialNumber, :slots,
                  :stackMode, :type, :uri, :userDescription, :uuid, :vpdID, :ntpPushEnabled,
                  :ntpPushFrequency, :location, :height, :memoryUtilization, :mgmtProcIPaddress,
                  :temperatureSensors, :entitleSerialNumber, :manufacturingDate, :panicDump,
                  :powerSupply, :stackRole, :fans, :contact, :sysObjectID, :savePending, :resetReason,
                  :applyPending, :OS, :cpuUtilization, :ports, :upTime
  end
end
