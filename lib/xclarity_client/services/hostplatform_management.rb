require 'json'
require 'pathname'

module XClarityClient
  class HostPlatformManagement < Services::XClarityService
    manages_endpoint HostPlatform

    def get_osimage_deployment_status(uuid)
        response = @connection.do_get("#{HostPlatform::BASE_URI}/#{uuid}")
    end

    def deploy_osimage(opts=[])
        request_body = JSON.generate(opts)
        res = Schemas.validate_input(:deploy_osimage, request_body)
        if res[:result] == 'success'
           response = @connection.do_put("#{HostPlatform::BASE_URI}",
                                         request_body)
        else
           res
        end
    end
  end
end
