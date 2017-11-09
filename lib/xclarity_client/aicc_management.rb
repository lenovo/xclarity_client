# XClarityClient module/namespace
module XClarityClient
  # Aicc Management class
  class AiccManagement < XClarityBase
    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Aicc::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(Aicc, opts)
    end

  end
end