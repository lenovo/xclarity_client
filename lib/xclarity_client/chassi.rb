module XClarityClient
  class Chassi
    include XClarityClient::Resource

    BASE_URI = '/chassis'.freeze
    LIST_NAME = 'chassisList'.freeze

    attr_accessor :properties, :_id, :accessState, :activationKeys, :activeAlerts, :backedBy, :bladeSlots,
    :cmmDisplayName, :cmmHealthState, :cmms, :cmmSlots, :complex, :contact, :dataHandle,
    :description, :domainName, :encapsulation, :energyPolicies, :errorFields,
    :excludedHealthState, :fanMuxes, :fanMuxSlots, :fans, :fanSlots, :height, :hostname,
    :isConnectionTrusted, :ledCardSlots, :leds, :location, :machineType, :managerName,
    :managerUuid, :manufacturer, :manufacturerId, :mgmtProcIPaddress, :model, :name,
    :nist, :nodes, :partNumber, :passThroughModules, :posID, :powerAllocation,
    :powerSupplySlots, :powerSupplies, :productId, :overallHealthState, :SecurityPolicy,
    :serialNumber, :status, :switches, :switchSlots, :tlsVersion, :type, :userDescription,
    :uri, :uuid, :vpdID, :mmSlots, :displayName, :productName, :parent, :fruNumber, :password, :recoveryPassword,
    :username, :managementPorts, :ipAddresses

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
