require 'json'
require 'pathname'

module XClarityClient
  class GlobalSettingManagement < Services::XClarityService
    manages_endpoint GlobalSetting

    def set_globalsettings(opts={})
        request_body = JSON.generate(opts)
        if Schemas.validate_input(:set_globalsettings, request_body)
          response = @connection.do_put("#{GlobalSetting::BASE_URI}", request_body)
        end
    end
  end
end
