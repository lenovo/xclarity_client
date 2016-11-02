require "pp"

module XClarityClient
  class Cmm
    include XClarityClient::Resource

    BASE_URI = '/cmms'.freeze

    attr_accessor :_id, :properties, :accessState, :backedBy, :cmmDisplayName, :cmmHealthState, :dataHandle, :dnsHostnames, :domainName, :errorFields,
    :excludedHealthState, :firmware, :FRU, :fruSerialNumber, :hostConfig, :hostname, :ipInterfaces, :ipv4Addresses, :ipv6Addresses,
    :macAddresses, :machineType, :mgmtProcIPaddress, :model, :name, :overallHealthState, :parent, :partNumber, :powerAllocation,
    :productId, :role, :serialNumber, :slots, :type, :userDescription, :uri, :uuid,:description, :leds, :manufacturerId, :manufacturer

    def initialize(attributes)
      build_resource(attributes)
    end
  end
end
