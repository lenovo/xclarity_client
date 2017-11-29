require 'json'

module XClarityClient
  class UpdateCompManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, UpdateComp::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(UpdateComp, opts)
    end

    def get_updatable_device_comp()
      response = connection(UpdateComp::BASE_URI + "?action=getComponents")
      return [] unless response.success?

      body = JSON.parse(response.body)

      body = {UpdateComp::LIST_NAME => body} if body.is_a? Array
      body = {UpdateComp::LIST_NAME => [body]} unless body.has_key? UpdateComp::LIST_NAME
      body[UpdateComp::LIST_NAME].map do |resource_params|
        UpdateComp.new resource_params
      end
    end

    def apply_firmware_update(activationMode, forceUpdateMode, onErrorMode, server, switch, storage, cmm)
      validate_arguments(activationMode, forceUpdateMode, onErrorMode)

      uri = create_uri(activationMode, forceUpdateMode, onErrorMode)

      apply_req = create_req_json(server, switch, storage, cmm) 
      response = do_put(UpdateComp::BASE_URI + '?action=apply' + uri, apply_req)
      puts response.body 
    end

    def cancel_firmware_update(server, switch, storage, cmm)
      cancel_req = create_req_json(server, switch, storage, cmm)
      response = do_put(UpdateComp::BASE_URI + '?action=cancelApply', cancel_req)
      puts response.body
    end
 
    def modify_power_state(server, switch, storage, cmm)
      power_state_req = create_req_json(server, switch, storage, cmm)
      response = do_put(UpdateComp::BASE_URI + '?action=powerState', power_state_req)
      puts response.body
    end
  
    def validate_arguments(activationMode, forceUpdateMode, onErrorMode)
      if !activationMode.nil? and !activationMode.downcase.eql? "immediate" and !activationMode.downcase.eql? "delayed"
        raise "Invalid argument specified. Operation apply_firmware_update can have activationMode as either immediare or delayed."
      end

      if !forceUpdateMode.nil? and !forceUpdateMode.downcase.eql? "true" and !forceUpdateMode.downcase.eql? "false"
        raise "Invalid argument specified. Value for forceUpdateMode on operation apply_firmware_update should have a value of either true or false" 
      end
      
      if !onErrorMode.nil? and !onErrorMode.eql? "stopOnError" and !onErrorMode.eql? "stopdeviceOnError" and !onErrorMode.eql? "continueOnError"
        raise "Invalid argument specified. Operation apply_firmware_update should have onErrorMode as : 'stopOnError' or 'stopdeviceOnError' or 'continueOnError'"
      end
    end

    def create_uri(activationMode, forceUpdateMode, onErrorMode)
      uri = ""
      if !activationMode.nil?
        uri = uri + "&activationMode=" + activationMode
      end
      if !forceUpdateMode.nil?
        uri = uri + "&forceUpdateMode=" + forceUpdateMode
      end
      if !onErrorMode.nil?
        uri = uri + "&onErrorMode=" + onErrorMode
      end
      uri
    end

    def create_req_json(server, switch, storage, cmm)
      server_json = JSON.generate(:ServerList => server)
      switch_json = JSON.generate(:SwitchList => switch)
      storage_json = JSON.generate(:StorageList => storage)
      cmm_json = JSON.generate(:CMMList => cmm)

      req_json = "{\"DeviceList\": [#{server_json},#{switch_json},#{storage_json},#{cmm_json}]}"
      req_json
    end
  
  end
end
