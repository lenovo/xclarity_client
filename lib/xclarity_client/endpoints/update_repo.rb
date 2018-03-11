module XClarityClient
  class UpdateRepo < Endpoints::XclarityEndpoint
    BASE_URI = '/updateRepositories/firmware'.freeze
    LIST_NAME = 'updateRepoList'.freeze

    attr_accessor :importDir, :status, :lastRefreshed, :size, :publicKeys, :updates, :updatesByMt, :supportedMts, :updatesByMtByComp
  end
end
