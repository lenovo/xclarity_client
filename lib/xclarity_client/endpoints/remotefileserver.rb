module XClarityClient
  class RemoteFileServer < Endpoints::XclarityEndpoint
    BASE_URI = '/osImages/remoteFileServers'.freeze
    LIST_NAME = 'serverList'.freeze

    attr_accessor :protocol, :address, :port,
                  :displayName, :serverId, :username,
                  :keyType, :serverPublicKey

  end
end
