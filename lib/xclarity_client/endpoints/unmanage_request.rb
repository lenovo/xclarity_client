module XClarityClient
  class UnmanageRequest
    include XClarityClient::Resource

    BASE_URI = '/unmanageRequest'.freeze
    LIST_NAME = 'unmanageRequestList'.freeze

    attr_accessor :progress, :results, :messageBundle, :messageID, :messageParameters, :result, :resultLongDescription, :resultShortDescription, :status, :taskid, :time_spent, :uuid

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
