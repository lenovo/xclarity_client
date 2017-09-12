require 'json'
require 'uuid'

module XClarityClient
  class ConfigtargetManagement < XClarityBase
    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Configtarget::BASE_URI)
    end

  end
end

