module XClarityClient
  class Job
    include XClarityClient::Resource

    BASE_URI = '/jobs'.freeze
    LIST_NAME = 'jobsList'.freeze

    attr_accessor :status, :cancelledBy, :createdBy, :category, :typeId, :messageDisplay, :cancelURI,
    :messageParameters, :startTime, :messageID, :messageBundle, :endTime, :id, :isCancelable, :rebootPersistent,
    :uuid, :hidden

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
