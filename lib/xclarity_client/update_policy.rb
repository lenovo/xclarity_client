module XClarityClient
  class UpdatePolicy
    include XClarityClient::Resource

    BASE_URI = '/compliancePolicies'.freeze
    LIST_NAME = 'updatePolicyList'.freeze

    attr_accessor :policies, :id, :inUse, :lastModified, :name, :updateRule, :userDefined, :description, :details, :componentTypes, :applicableFirmware, :machineType, :uuid, :jobid, :percentage, :result, :endpointCompliant, :message, :status, :targetFirmware, :taskid, :all, :chassis, :cmms, :racklist, :rackswitchlist, :storagelist, :switches, :xITEs, :message, :success, :messages, :explanation, :recovery, :text

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
