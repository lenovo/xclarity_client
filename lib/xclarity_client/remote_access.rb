module XClarityClient
  class RemoteAccess < XClarityBase
    include XClarityClient::Resource

    BASE_URI = '/remoteaccess'.freeze

    attr_accessor :type, :resource

    def initialize(attributes)
      build_resource(attributes)
    end
  end
end

