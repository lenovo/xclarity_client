require 'json'

module XClarityClient
  class FanMuxManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, FanMux::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(FanMux, opts)
    end

  end
end
