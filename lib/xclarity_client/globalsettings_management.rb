require 'json'
require 'pathname'
require 'xclarity_client/schemas'

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
        x=JSON::Validator.fully_validate(Schemas::REQ_SCHEMA["globalSettings_put"], request_body)
        $lxca_log.info self.class.to_s+" "+__method__.to_s, opts.to_s
        if not x.empty?
          errmsg = "input validation failed for" +self.class.to_s+" "+__method__.to_s
          puts "input validation failed"
          for k in x
            $lxca_log.error errmsg, k
            puts k
          end
          return
        end
        response = do_put("#{GlobalSetting::BASE_URI}", request_body)
        response = JSON.parse(response.body)
    end
  end
end
