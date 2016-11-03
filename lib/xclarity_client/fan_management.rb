require 'json'

module XClarityClient
  class FanManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Fan::BASE_URI)
    end

    def population
      get_all_resources(Fan)
    end

  end
end
