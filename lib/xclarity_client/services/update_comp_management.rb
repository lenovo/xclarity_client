require 'json'

module XClarityClient
  # update component management class
  class UpdateCompManagement < Services::XClarityService
    manages_endpoint UpdateComp

    def updatable_device_comp
      response = @connection.do_get(UpdateComp::BASE_URI\
                                    + '?action=getComponents')
      return [] unless response.success?
      body = JSON.parse(response.body)
      body = { UpdateComp::LIST_NAME => body } if body.kind_of?(Array)
      j = body.key?(UpdateComp::LIST_NAME)
      body = { UpdateComp::LIST_NAME => [body] } unless j
      body[UpdateComp::LIST_NAME].map do |resource_params|
        UpdateComp.new(resource_params)
      end
    end

    def apply_firmware_update(opts, activation_mode, force_update_mode,
                              onerror_mode)
      validate_arguments(activation_mode, force_update_mode, onerror_mode)

      uri = create_uri(activation_mode, force_update_mode, onerror_mode)

      apply_req = create_req_json(opts['server'], opts['switch'],
                                  opts['storage'], opts['cmm'])
      response = @connection.do_put(UpdateComp::BASE_URI + '?action=apply'\
                                    + uri, apply_req)
      response.body
    end

    def cancel_firmware_update(server, switch, storage, cmm)
      cancel_req = create_req_json(server, switch, storage, cmm)
      response = @connection.do_put(UpdateComp::BASE_URI\
                                    + '?action=cancelApply',
                                    cancel_req)
      response.body
    end

    def modify_power_state(server, switch, storage, cmm)
      power_state_req = create_req_json(server, switch, storage, cmm)
      response = @connection.do_put(UpdateComp::BASE_URI + '?action=powerState',
                                    power_state_req)
      response.body
    end

    def validate_activation_mode(activation_mode)
      if !activation_mode.nil? && !activation_mode.casecmp('immediate').zero? &&
         !activation_mode.casecmp('delayed').zero?

        raise 'Invalid argument specified. Operation apply_firmware_update'\
               + ' can have activationMode as either immediare or delayed.'
      end
    end

    def validate_forceupdate_mode(forceupdate_mode)
      if !forceupdate_mode.nil? && !forceupdate_mode.casecmp('true').zero? &&
         !forceupdate_mode.casecmp('false').zero?

        raise 'Invalid argument specified. Value for forceUpdateMode on'\
              + ' operation apply_firmware_update should have a value'\
              + ' of either true or false'
      end
    end

    def validate_onerror_mode(onerror_mode)
      if !onerror_mode.nil? && !onerror_mode.eql?('stopOnError') &&
         !onerror_mode.eql?('stopdeviceOnError') &&
         !onerror_mode.eql?('continueOnError')

        raise 'Invalid argument specified. Operation apply_firmware_update'\
              + " should have onErrorMode as : 'stopOnError' or"\
              + " 'stopdeviceOnError' or 'continueOnError'"
      end
    end

    def validate_arguments(activation_mode, forceupdate_mode, onerror_mode)
      validate_activation_mode(activation_mode)
      validate_forceupdate_mode(forceupdate_mode)
      validate_onerror_mode(onerror_mode)
    end

    # splitted create_uri just to fix codeclimate error
    def add_uri(force_update_mode, onerror_mode, uri)
      fmode = force_update_mode.nil?
      uri += '&forceUpdateMode=' + force_update_mode unless fmode
      uri += '&onErrorMode=' + onerror_mode unless onerror_mode.nil?
      uri
    end

    def create_uri(activation_mode, force_update_mode, onerror_mode)
      uri = ''
      amode = activation_mode.nil?
      uri += '&activationMode=' + activation_mode unless amode
      add_uri(force_update_mode, onerror_mode, uri)
    end

    def create_req_json(server, switch, storage, cmm)
      server_json = JSON.generate(:ServerList => server)
      switch_json = JSON.generate(:SwitchList => switch)
      storage_json = JSON.generate(:StorageList => storage)
      cmm_json = JSON.generate(:CMMList => cmm)

      req_json = "{\"DeviceList\": [#{server_json},#{switch_json},"\
                 + "#{storage_json},#{cmm_json}]}"
      req_json
    end
  end
end
