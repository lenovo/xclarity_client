module XClarityClient
  class switches

    BASE_URI = '/switches'.freeze

    attr_accessor :accessState, :attachedNodes, :cmmHealthState, :firmware, :macAddress, :productName, :serialNumber, :type, :uuid

    def initialize(attributes)
      build_switch(attributes)
    end

    def build_switch(atributes)
      attributes.each do |key, value|
        send("#{key}=", value)
  end
end
