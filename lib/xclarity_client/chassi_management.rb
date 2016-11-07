require 'json'

module XClarityClient
  class ChassiManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Chassi::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(Chassi, opts)
    end

  end
end
