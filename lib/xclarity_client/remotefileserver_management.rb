require 'json'
require 'xclarity_client/schemas'

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
      x=JSON::Validator.fully_validate(Schemas::REQ_SCHEMA["remoteFileServers_post"], request_body) 
      if not x.empty?
         errmsg = "input validation failed for"+self.class.to_s+" "+__method__.to_s
         puts "input validation failed"
         for k in x
            $lxca_log.error errmsg, k 
            puts k
         end
         return
      end
      response = do_post(RemoteFileServer::BASE_URI, request_body)
      msg = "remote file server profile created #{response.body}"
      $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
      response = JSON.parse(response.body)
    end

    def delete_remotefileserver_profile(serverId)
      if not serverId.kind_of?(String)
           puts "Invalid input, serverId must be of type string"
           return
      end
      response = do_delete("#{RemoteFileServer::BASE_URI}/#{serverId}")
      msg = "remote file server profile deleted for serverid #{serverId}"
      $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
      response = JSON.parse(response.body)
    end

    def get_remotefileserver_profile(serverId)
      if not serverId.kind_of?(String)
           puts "Invalid input, serverId must be of type string"
           return
      end
      response = connection("#{RemoteFileServer::BASE_URI}/#{serverId}")
      msg = "for serverid #{serverId}"
      $lxca_log.info self.class.to_s+" "+__method__.to_s, msg
      response = JSON.parse(response.body)
    end
  end
end
