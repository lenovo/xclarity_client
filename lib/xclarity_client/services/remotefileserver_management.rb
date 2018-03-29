require 'json'

module XClarityClient
  class RemoteFileServerManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, RemoteFileServer::BASE_URI)
    end

    def population
      get_all_resources(RemoteFileServer)
    end

    def create_remotefileserver_profile(opts) 
      request_body = JSON.generate(opts)
      if not Schemas.validate_input("create_remotefileserver_profile", request_body)
         return
      end
      response = do_post(RemoteFileServer::BASE_URI, request_body)
      msg = "remote file server profile created #{response.body}"
      $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
      response = JSON.parse(response.body)
    end

    def delete_remotefileserver_profile(serverId)
      if not Schemas.validate_input_parameter("serverId", serverId, String)
         return
      end
      response = do_delete("#{RemoteFileServer::BASE_URI}/#{serverId}")
      msg = "remote file server profile deleted for serverid #{serverId}"
      $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
      response = JSON.parse(response.body)
    end

    def get_remotefileserver_profile(serverId)
      if not Schemas.validate_input_parameter("serverId", serverId, String)
         return
      end
      response = connection("#{RemoteFileServer::BASE_URI}/#{serverId}")
      msg = "for serverid #{serverId}"
      $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
      response = JSON.parse(response.body)
    end
  end
end
