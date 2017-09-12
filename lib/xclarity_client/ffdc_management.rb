require 'json'
require 'uuid'

module XClarityClient
  class FfdcManagement < XClarityBase
    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Ffdc::BASE_URI)
    end

  end
end
