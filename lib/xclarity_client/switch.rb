module XClarityClient
  class Switch

    BASE_URI = '/switches'.freeze

    attr_accessor :properties, :_id, :accessState, :attachedNodes, :cmmHealthState, :excludedHealthState, :firmware, :hostname, :ipInterfaces, :ipv4Address,
    :ipv6Address, :leds, :macAddress, :powerState, :productName, :protectedMode, :overallHealthState, :serialNumber, :type, :uuid


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
