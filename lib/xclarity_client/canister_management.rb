require 'json'

module XClarityClient
  class CanisterManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Canister::BASE_URI)
    end

    def population
      get_all_resources(Canister)
    end

  end
end
