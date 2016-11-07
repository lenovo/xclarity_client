require 'json'

module XClarityClient
  class CmmManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Cmm::BASE_URI)
    end

    def population
      get_all_resources(Cmm)
    end

  end
end
