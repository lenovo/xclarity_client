module XClarityClient
  class PersistedResult
    include XClarityClient::Resource

    BASE_URI = '/compliancePolicies/persistedResult'.freeze
    LIST_NAME = 'all'.freeze

    attr_accessor :switches, :chassis, :xITEs, :message, :cmms, :racklist

    def initialize(attributes)
      build_resource(attributes)
    end
  end
end
