module XClarityClient
  class Chassi
    BASE_URI = '/chassis'.freeze

    attr_accessor :properties, :_id, :accessState, :activationKeys, :activeAlerts, :backedBy, :bladeSlots,
    :cmmDisplayName, :cmmHealthState, :cmms, :cmmSlots, :complex, :contact, :dataHandle,
    :description, :domainName, :encapsulation, :energyPolicies, :errorFields,
    :excludedHealthState, :fanMuxes, :fanMuxSlots, :fans, :fanSlots, :height, :hostname,
    :isConnectionTrusted, :ledCardSlots, :leds, :location, :machineType, :managerName,
    :managerUuid, :manufacturer, :manufacturerID, :mgmtProcIPaddress, :model, :name,
    :nist, :nodes, :partNumber, :passThroughModules, :posID, :powerAllocation,
    :powerSupplySlots, :powerSupplies, :productID, :overallHealthState, :securityPolicy,
    :serialNumber, :status, :switches, :switchSlots, :tlsVersion, :type, :userDescription,
    :uri, :uuid, :vpdID

    def initialize(attributes)
      build_chassi(attributes)
    end

    def build_chassi(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end
  end
end
