module XClarityClient
  #
  # Exposes RemoteFileServerManagement features
  #
  module Mixins::RemoteFileServerMixin
    def get_remotefileserver_profiles
      RemoteFileServerManagement.new(@config).fetch_all
    end

    def create_remotefileserver_profile(opts = {})
      RemoteFileServerManagement.new(@config).create_remotefileserver_profile(
        opts
      )
    end

    def delete_remotefileserver_profile(server_id = '')
      RemoteFileServerManagement.new(@config).delete_remotefileserver_profile(
        server_id
      )
    end

    def get_remotefileserver_profile(server_id = '')
      RemoteFileServerManagement.new(@config).get_remotefileserver_profile(
        server_id
      )
    end
  end
end
