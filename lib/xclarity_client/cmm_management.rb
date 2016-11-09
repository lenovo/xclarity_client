require 'json'

module XClarityClient
  class CmmManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Cmm::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(Cmm, opts)
    end

  end
end
