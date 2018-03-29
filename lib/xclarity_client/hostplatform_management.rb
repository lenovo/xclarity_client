require 'json'
require 'pathname'
require 'xclarity_client/schemas'

module XClarityClient
  class HostPlatformManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
        super(conf, HostPlatform::BASE_URI)
    end

    def population
        get_all_resources(HostPlatform)
    end

    def get_osimage_deployment_status(uuid)
        if not uuid.kind_of?(String)
           puts "Invalid input, uuid must be of type string"
           return
        end
        response = connection("#{HostPlatform::BASE_URI}/#{uuid}")
        response = JSON.parse(response.body)
    end

    def deploy_osimage(opts=[])
        request_body = JSON.generate(opts)
        x=JSON::Validator.fully_validate(Schemas::REQ_SCHEMA["hostPlatforms_put"], request_body)
        if not x.empty?
          errmsg = "input validation failed for"+self.class.to_s+" "+__method__.to_s
          puts "input validation failed"
          for k in x
            $lxca_log.error errmsg, k
            puts k
          end
          return
        end
        response = do_put("#{HostPlatform::BASE_URI}", request_body)
        response = JSON.parse(response.body)
    end
  end
end
