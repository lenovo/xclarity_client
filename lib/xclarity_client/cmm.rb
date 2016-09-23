module XClarityClient
  class Cmm

    BASE_URI = '/cmms'.freeze

    attr_accessor :_id, :properties, :accessState, :backedBy, :cmmDisplayName, :cmmHealthState, :dataHandle, :dnsHostNames, :domainName, :errorFields,
    :excludedHealthState, :firmware, :FRU, :fruSerialNumber, :hostConfig, :hostname, :ipInterfaces, :ipv4Addresses, :ipv6Addresses,
    :macAddresses, :machineType, :mgmtProcIPaddress, :model, :name, :overallHealthState, :parent, :partNumber, :powerAllocation,
    :productID, :role, :serialNumber, :slots, :type, :userDescription, :uri, :uuid

    def initialize(attributes)
        build_cmm(attributes)
      end

      def build_cmm(attributes)
        attributes.each do |key, value|
          send("#{key}=", value)
        end
      end
    end
  end
