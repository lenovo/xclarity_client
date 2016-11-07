require 'json'

module XClarityClient
  class PowerSupplyManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, PowerSupply::BASE_URI)
    end

    def population
      get_all_resources(PowerSupply)
    end

  end
end
