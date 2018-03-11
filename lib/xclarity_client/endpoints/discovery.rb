module XClarityClient
  class Discovery < Endpoints::XclarityEndpoint
    BASE_URI = '/discovery'.freeze
    LIST_NAME = 'deviceList'.freeze

    attr_accessor :lastUpdateElapsedTime, :storageList, :discoveryInProgress, :rackswitchList, :xhmcList, :chassisList, :nodeList, :securityDescriptor, :serialNumber, :displayName, :managementPorts, :type, :uuid, :password, :hostname, :fruNumber, :recoveryPassword, :name, :subType, :model, :ipAddresses, :firmware, :machineType, :username, :status, :cmmDisplayName, :cmms, :enablePassword, :wwnn, :software
  end
end
