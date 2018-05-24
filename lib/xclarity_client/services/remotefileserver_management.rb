require 'json'

module XClarityClient
  class RemoteFileServerManagement < Services::XClarityService
    manages_endpoint RemoteFileServer

    def create_remotefileserver_profile(opts) 
      request_body = JSON.generate(opts)
      if Schemas.validate_input(:create_remotefileserver_profile, request_body)
        response = @connection.do_post(RemoteFileServer::BASE_URI, request_body)
        msg = "remote file server profile created #{response.body}"
        $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
        response
      end
    end

    def delete_remotefileserver_profile(serverId)
      if not Schemas.validate_input_parameter("serverId", serverId, String)
         return
      end
      response = @connection.do_delete("#{RemoteFileServer::BASE_URI}/#{serverId}")
    end

    def get_remotefileserver_profile(serverId)
      if Schemas.validate_input_parameter("serverId", serverId, Integer)
        response = @connection.do_get("#{RemoteFileServer::BASE_URI}/#{serverId}")
      end
    end
  end
end
