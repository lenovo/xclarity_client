require 'json'

module XClarityClient
  class ChassiManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Chassi::BASE_URI)
    end

    def population
      get_all_resources(Chassi)
    end

  end
end
