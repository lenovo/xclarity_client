require 'json'
require 'pathname'

module XClarityClient
  class HostPlatformManagement < Services::XClarityService
    manages_endpoint HostPlatform

    def get_osimage_deployment_status(uuid)
        if Schemas.validate_input_parameter("uuid", uuid, String)
          response = @connection.do_get("#{HostPlatform::BASE_URI}/#{uuid}")
        end
    end

    def deploy_osimage(opts=[])
        request_body = JSON.generate(opts)
        if Schemas.validate_input(:deploy_osimage, request_body)
          response = @connection.do_put("#{HostPlatform::BASE_URI}", request_body)
        end
    end
  end
end
