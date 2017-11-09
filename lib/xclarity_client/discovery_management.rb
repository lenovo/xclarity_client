require 'json'

module XClarityClient
  class DiscoveryManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Discovery::BASE_URI)
    end

    def population()
      get_all_resources(Discovery)
    end

  end
end
