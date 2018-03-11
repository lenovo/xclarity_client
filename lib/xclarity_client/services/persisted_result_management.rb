require 'json'

module XClarityClient
  class PersistedResultManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, PersistedResult::BASE_URI)
    end

    def population
      get_all_resources(PersistedResult)
    end
  end
end
