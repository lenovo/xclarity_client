module XClarityClient
  class UpdateRepo
    include XClarityClient::Resource

    BASE_URI = '/updateRepositories/firmware'.freeze
    LIST_NAME = 'updateRepoList'.freeze

    attr_accessor :importDir, :status, :lastRefreshed, :size, :publicKeys, :updates, :updatesByMt, :supportedMts, :updatesByMtByComp

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
