module XClarityClient
  class RemoteAccess < Endpoints::XclarityEndpoint
    BASE_URI = '/remoteaccess'.freeze

    attr_accessor :type, :resource
  end
end

