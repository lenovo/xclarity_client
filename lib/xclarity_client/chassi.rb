module XClarityClient
  class Chassi
    include XClarityClient::Resource

    BASE_URI = '/chassis'.freeze
    LIST_NAME = 'chassisList'.freeze

    attr_accessor :accessState, :activationKeys, :activeAlerts, :backedBy,
                  :bladeSlots, :cmmDisplayName, :cmmHealthState, :cmms, :complex,
                  :contact, :dataHandle, :description, :displayName, :domainName,
                  :energyPolicies, :errorFields, :excludedHealthState, :fanMuxes,
                  :fanMuxSlots, :fans, :fanSlots, :fruNumber, :height, :hostname,
                  :ipAddresses, :isConnectionTrusted, :ledCardSlots, :leds,
                  :location, :machineType, :managementPorts, :managerName, 
                  :managerUuid, :manufacturer, :manufacturerId, :mgmtProcIPaddress,
                  :mmSlots, :model, :name, :nist, :nodes, :overallHealthState, 
                  :partNumber, :passThroughModules, :password, :posID,
                  :powerAllocation, :powerSupplies, :powerSupplySlots, :productId,
                  :productName, :recoveryPassword, :SecurityPolicy, :serialNumber,
                  :status, :switches, :switchSlots, :tlsVersion, :type, :uri,
                  :userDescription, :username, :uuid, :vpdID

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
