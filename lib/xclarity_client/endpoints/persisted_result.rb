module XClarityClient
  class PersistedResult < Endpoints::XclarityEndpoint
    BASE_URI = '/compliancePolicies/persistedResult'.freeze
    LIST_NAME = 'all'.freeze

    attr_accessor :switches, :chassis, :xITEs, :message, :cmms, :racklist
  end
end
