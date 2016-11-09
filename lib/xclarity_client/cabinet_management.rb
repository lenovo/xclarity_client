require 'json'

module XClarityClient
  class CabinetManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Cabinet::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(Cabinet, opts)
    end

  end
end
