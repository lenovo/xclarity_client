module XClarityClient
  class DiscoverRequest
    include XClarityClient::Resource

    BASE_URI = '/discoverRequest'.freeze
    LIST_NAME = 'deviceList'.freeze

    attr_accessor :result, :rackswitchList, :serverList, :xhmcList, :progress, :chassisList, :cmmDisplayName, :cmms, :displayName, :fruNumber, :hostname, :ipAddresses, :machineType, :managementPorts, :model, :name, :password, :recoveryPassword, :serialNumber, :status, :type, :username, :uuid, :enablePassword, :firmware, :os, :subType

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
