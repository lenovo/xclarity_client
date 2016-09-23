module XClarityClient
  class Switch

    BASE_URI = '/switches'.freeze

    attr_accessor :properties, :_id, :accessState, :applyPending, :attachedNodes, :cmmDisplayName, :cmmHealthState, :entitleSerialNumber, :fans, :firmware, :hostname, :ipInterfaces,
    :leds, :macAddress, :machineType, :manufacturer, :manufacturerID, :ports, :productID, :productName, :protectedMode, :serialNumber, :type, :upTime, :uuid, :accessState, :cmmHealthState, :excludedHealthState,
    :memoryUtilization, :model, :overallHealthState, :panicDump, :powerState, :savePending, :slots, :posID, :stackMode, :stackedMode, :stackRole, :sysObjectID, :temperatureSensors, :userDescription, :vpdID,
    :contact, :cpuUtilization, :dataHandle, :description, :dnsHostnames, :domainName, :errorFields, :FRU, :fruSerialNumber, :ipv4Address, :ipv6Address, :ipInterfaces, :manufacturingDate, :name, :resetReason, :uri


    def initialize(attributes)
      build_switch(attributes)
    end

    def build_switch(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

  end
end
