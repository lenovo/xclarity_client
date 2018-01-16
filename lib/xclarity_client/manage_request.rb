module XClarityClient
  class ManageRequest
    include XClarityClient::Resource

    BASE_URI = '/manageRequest'.freeze
    LIST_NAME = 'manageRequestList'.freeze

    attr_accessor :progress, :results, :messageBundle, :messageID, :messageParameters, :result, :resultLongDescription, :resultShortDescription, :status, :taskid, :time_spent, :uuid

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
