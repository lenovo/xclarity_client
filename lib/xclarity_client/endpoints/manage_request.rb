module XClarityClient
  # ManageRequest class
  class ManageRequest < Endpoints::XclarityEndpoint
    BASE_URI = '/manageRequest'.freeze
    LIST_NAME = 'manageRequestList'.freeze

    attr_accessor :progress, :results, :messageBundle, :messageID,
                  :messageParameters, :result, :resultLongDescription,
                  :resultShortDescription, :status, :taskid, :time_spent, :uuid
  end
end
