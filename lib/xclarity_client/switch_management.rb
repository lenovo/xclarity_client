require 'json'

module XClarityClient
  class SwitchManagement < XClarityBase
    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Switch::BASE_URI)
    end

    def population
      get_all_resources(Switch)
    end

  end
end
