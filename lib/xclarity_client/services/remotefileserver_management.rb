require 'json'

module XClarityClient
  class RemoteFileServerManagement < Services::XClarityService
    manages_endpoint RemoteFileServer

    def create_remotefileserver_profile(opts) 
      request_body = JSON.generate(opts)
      res = Schemas.validate_input(:create_remotefileserver_profile,
                                   request_body)
      if res[:result] == 'success'
        response = @connection.do_post(RemoteFileServer::BASE_URI,
                                       request_body)
      else
        res
      end
    end

    def delete_remotefileserver_profile(serverId)
        response = @connection.do_delete("#{RemoteFileServer::BASE_URI}/"\
                                         "#{serverId}")
    end

    def get_remotefileserver_profile(serverId)
        response = @connection.do_get("#{RemoteFileServer::BASE_URI}/"\
                                      "#{serverId}")
    end
  end
end
