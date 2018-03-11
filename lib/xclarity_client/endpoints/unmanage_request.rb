module XClarityClient
  class UnmanageRequest < Endpoints::XclarityEndpoint
    BASE_URI = '/unmanageRequest'.freeze
    LIST_NAME = 'unmanageRequestList'.freeze

    attr_accessor :progress, :results, :messageBundle, :messageID, :messageParameters, :result, :resultLongDescription, :resultShortDescription, :status, :taskid, :time_spent, :uuid
  end
end
