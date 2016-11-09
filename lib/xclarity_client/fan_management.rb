require 'json'

module XClarityClient
  class FanManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Fan::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(Fan, opts)
    end

  end
end
