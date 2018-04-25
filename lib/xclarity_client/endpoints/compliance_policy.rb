module XClarityClient
  class CompliancePolicy < Endpoints::XclarityEndpoint

    BASE_URI = '/compliancePolicies'.freeze
    LIST_NAME = 'updatePolicyList'.freeze
    SUB_URIS = {
                 applicableFirmware: "#{BASE_URI}/applicableFirmware",
                 persistedResult: "#{BASE_URI}/persistedResult",
                 compareResult: "#{BASE_URI}/compareResult"
               }

    attr_accessor :policies, :id, :inUse, :lastModified, :name, :updateRule, :userDefined,
                  :description, :details, :componentTypes, :applicableFirmware,
                  :machineType, :uuid, :jobid, :percentage, :result, :endpointCompliant,
                  :message, :status, :targetFirmware, :taskid, :all, :chassis, :cmms,
                  :racklist, :rackswitchlist, :storagelist, :switches, :xITEs, :message,
                  :success, :messages, :explanation, :recovery, :text
  end
end
