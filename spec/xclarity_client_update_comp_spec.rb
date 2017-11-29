require 'spec_helper'

describe XClarityClient do

  before :all do
    WebMock.allow_net_connect! #-- Uncomment this line if you're testing with a external mock.

    conf = XClarityClient::Configuration.new(
    :username => ENV['LXCA_USERNAME'],
    :password => ENV['LXCA_PASSWORD'],
    :host     => ENV['LXCA_HOST'],
    :port     => ENV['LXCA_PORT'],
    :auth_type => ENV['LXCA_AUTH_TYPE'],
    :verify_ssl => ENV['LXCA_VERIFY_SSL'],
    :user_agent_label => ENV['LXCA_USER_AGENT_LABEL']
    )

    @client = XClarityClient::Client.new(conf)

    @host = ENV['LXCA_HOST']
    @user_agent = "ruby/0.5.4" 

    @server = [{"UUID": "8BFBADCC33CB11E499F740F2E9903640","Components": [{"Fixid": "lnvgy_fw_storage_1.1.1","Component": "Controller a"}]}]
    @switch = [{"UUID": "8BFBADCC33CB11E499F740F2E9903640","Components": [{"Fixid": "lnvgy_fw_scsw_en4093r-8.3.9.0_anyons_noarch","Component": "Main application"}]}]
    @storage = [{"UUID": "8BFBADCC33CB11E499F740F2E9903640","Components": [{"Fixid": "lnvgy_fw_storage_1.1.1","Component": "Controller a"}]}]
    @cmm = [{"UUID": "8BFBADCC33CB11E499F740F2E9903640","Components": [{"Fixid": "lnvgy_fw_storage_1.1.1","Component": "Controller a"}]}]
    
    @power_state_server = [{"PowerState": "reset","UUID": "8BFBADCC33CB11E499F740F2E9972457"}]
    @power_state_switch = [{"PowerState": "powerOn","UUID": "8BFBADCC33CB11E499F740F2E9972458"}]
    @power_state_storage = [{"PowerState": "powerCycleSoft","UUID": "8BFBADCC33CB11E499F740F2E9972457"}]
    @power_state_cmm = [{"PowerState": "reset","UUID": "8BFBADCC33CB11E499F740F2E213123"}]
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  describe 'GET /updatableComponents' do
    context 'get updateComponents with default action of applyStatus' do
      it 'should respond with an array' do
        expect(@client.discover_firmware_update_status).not_to be_empty
      end
    end
    
    context 'get updateComponents with action of getComponents' do
      it 'should respond with an array' do
        expect(@client.discover_updatable_device_comp).not_to be_empty
      end
    end
  end

  describe 'PUT /updateableComponents negative cases' do
    context 'with an invalid value for activationMode' do
      it 'should throw an error' do
        expect {@client.apply_firmware_update("dummy", nil, nil, @server, @switch, @storage, @cmm)}.to raise_error(RuntimeError, 'Invalid argument specified. Operation apply_firmware_update can have activationMode as either immediare or delayed.')
      end
    end

    context 'with an invalid value for forceUpdateMode' do
      it 'should throw an error' do
        expect {@client.apply_firmware_update(nil, "nonBoolean", nil, @server, @switch, @storage, @cmm)}.to raise_error(RuntimeError, 'Invalid argument specified. Value for forceUpdateMode on operation apply_firmware_update should have a value of either true or false')
      end
    end

    context 'with an invalid value for onErrorMode' do
      it 'should throw an error' do
        expect {@client.apply_firmware_update(nil, nil, "dummy", @server, @switch, @storage, @cmm)}.to raise_error(RuntimeError, "Invalid argument specified. Operation apply_firmware_update should have onErrorMode as : 'stopOnError' or 'stopdeviceOnError' or 'continueOnError'")
      end
    end
  end

  describe 'PUT /updatableComponents positive cases' do
    context 'apply firmware updates with default values for activationMode, forceUpdateMode and onErrorMode' do
      it 'applies firmware updates' do
        @client.apply_firmware_update(nil, nil, nil, @server, @switch, @storage, @cmm)
        uri = "#{@host}/updatableComponents?action=apply"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},#{storage_json},#{cmm_json}]}"

        expect(a_request(:put, uri).with(:body => apply_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>@user_agent})).to have_been_made
      end
    end

    context 'apply firmware updates with activationMode set to delayed and default values for forceUpdateMode and onErrorMode' do
      it 'applies firmware updates' do
        @client.apply_firmware_update("delayed", nil, nil, @server, @switch, @storage, @cmm)
        uri = "#{@host}/updatableComponents?action=apply&activationMode=delayed"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},#{storage_json},#{cmm_json}]}"

        expect(a_request(:put, uri).with(:body => apply_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>@user_agent})).to have_been_made
      end
    end

    context 'apply firmware updates with forceUpdateMode set to true and default values for activationMode and onErrorMode' do
      it 'applies firmware updates' do
        @client.apply_firmware_update(nil, "true", nil, @server, @switch, @storage, @cmm)
        uri = "#{@host}/updatableComponents?action=apply&forceUpdateMode=true"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},#{storage_json},#{cmm_json}]}"

        expect(a_request(:put, uri).with(:body => apply_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>@user_agent})).to have_been_made
      end
    end

    context 'apply firmware updates with onErrorMode set to stopOnError and default values for activationMode and forceUpdateMode' do
      it 'applies firmware updates' do
        @client.apply_firmware_update(nil, nil, "stopOnError", @server, @switch, @storage, @cmm)
        uri = "#{@host}/updatableComponents?action=apply&onErrorMode=stopOnError"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},#{storage_json},#{cmm_json}]}"

        expect(a_request(:put, uri).with(:body => apply_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>@user_agent})).to have_been_made
      end
    end

    context 'apply firmware updates with onErrorMode set to continueOnError and default values for activationMode and forceUpdateMode' do
      it 'applies firmware updates' do
        @client.apply_firmware_update(nil, nil, "continueOnError", @server, @switch, @storage, @cmm)
        uri = "#{@host}/updatableComponents?action=apply&onErrorMode=continueOnError"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},#{storage_json},#{cmm_json}]}"

        expect(a_request(:put, uri).with(:body => apply_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>@user_agent})).to have_been_made
      end
    end

    context 'cancel firmware updates' do
      it 'cancels firmware updates' do
        @client.cancel_firmware_update(@server, @switch, @storage, @cmm)
        uri = "#{@host}/updatableComponents?action=cancelApply"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},#{storage_json},#{cmm_json}]}"

        expect(a_request(:put, uri).with(:body => apply_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>@user_agent})).to have_been_made
      end
    end

    context 'modify power state' do
      it 'modifies power state' do
        @client.modify_power_state(@power_state_server, @power_state_switch, @power_state_storage, @power_state_cmm)
        uri = "#{@host}/updatableComponents?action=powerState"

        power_state_server_json = JSON.generate(:ServerList => @power_state_server)
        power_state_switch_json = JSON.generate(:SwitchList => @power_state_switch)
        power_state_storage_json = JSON.generate(:StorageList => @power_state_storage)
        power_state_cmm_json = JSON.generate(:CMMList => @power_state_cmm)

        apply_json = "{\"DeviceList\": [#{power_state_server_json},#{power_state_switch_json},#{power_state_storage_json},#{power_state_cmm_json}]}"

        expect(a_request(:put, uri).with(:body => apply_json, :headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json', 'User-Agent'=>@user_agent})).to have_been_made
      end
    end
  end

end
