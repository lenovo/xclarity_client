require 'json'
require 'uuid'

module XClarityClient
  class ConfigTargetManagement < XClarityBase
    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, ConfigTarget::BASE_URI)
    end

  end
end

