require 'json'
require 'pathname'

module XClarityClient
  class GlobalSettingManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, GlobalSetting::BASE_URI)
    end

    def population
      response = connection("#{GlobalSetting::BASE_URI}")
      response = JSON.parse(response.body)
    end

    def set_globalsettings(opts={})
        request_body = JSON.generate(opts)
        if not Schemas.validate_input("set_globalsettings", request_body)
          return
        end
        response = do_put("#{GlobalSetting::BASE_URI}", request_body)
        response = JSON.parse(response.body)
    end
  end
end
