require 'spec_helper'

describe XClarityClient do

  before :all do
    #-- Uncomment below line if you're testing with a external mock.
    WebMock.allow_net_connect!

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
    @user_agent = ENV['LXCA_USER_AGENT_LABEL']

    @server = [{"UUID": "8BFBADCC33CB11E499F740F2E9903640","Components":
               [{"Fixid": "lnvgy_fw_storage_1.1.1","Component":
                 "Controller a"}]}]
    @switch = [{"UUID": "8BFBADCC33CB11E499F740F2E9903640","Components":
               [{"Fixid": "lnvgy_fw_scsw_en4093r-8.3.9.0_anyons_noarch",
                 "Component": "Main application"}]}]
    @storage = [{"UUID": "8BFBADCC33CB11E499F740F2E9903640","Components":
                [{"Fixid": "lnvgy_fw_storage_1.1.1","Component":
                  "Controller a"}]}]
    @cmm = [{"UUID": "8BFBADCC33CB11E499F740F2E9903640","Components":
            [{"Fixid": "lnvgy_fw_storage_1.1.1","Component": "Controller a"}]}]
    
    @power_state_server = [{"PowerState": "reset","UUID":
                            "8BFBADCC33CB11E499F740F2E9972457"}]
    @power_state_switch = [{"PowerState": "powerOn","UUID":
                            "8BFBADCC33CB11E499F740F2E9972458"}]
    @power_state_storage = [{"PowerState": "powerCycleSoft","UUID":
                             "8BFBADCC33CB11E499F740F2E9972457"}]
    @power_state_cmm = [{"PowerState": "reset","UUID":
                         "8BFBADCC33CB11E499F740F2E213123"}]
  end

  it 'has a version number' do
    expect(XClarityClient::VERSION).not_to be nil
  end

  #describe 'GET /updatableComponents' do
  #  context 'get updateComponents with default action of applyStatus' do
  #    it 'should respond with an array' do
  #      expect(@client.discover_firmware_update_status).not_to be_empty
  #    end
  #  end
    
  #  context 'get updateComponents with action of getComponents' do
  #    it 'should respond with an array' do
  #      expect(@client.discover_updatable_device_comp).not_to be_empty
  #    end
  #  end
  #end

  describe 'PUT /updateableComponents negative cases' do
    context 'with an invalid value for activationMode' do
      it 'should throw an error' do
        errmsg = 'Invalid argument specified. Operation apply_firmware_update'\
                 + ' can have activationMode as either immediare or delayed.'
        opts={"server"=>@server, "switch"=>@switch, "storage"=>@storage,
              "cmm"=>@cmm}
        expect {@client.apply_firmware_update(opts, "dummy", nil,
                nil)}.to raise_error(RuntimeError, errmsg)
      end
    end

    context 'with an invalid value for forceUpdateMode' do
      it 'should throw an error' do
        errmsg = 'Invalid argument specified. Value for forceUpdateMode'\
                 + ' on operation apply_firmware_update should have a value'\
                 + ' of either true or false'
        opts={"server"=>@server, "switch"=>@switch, "storage"=>@storage,
              "cmm"=>@cmm}
        expect {@client.apply_firmware_update(opts, nil, "nonBoolean",
                nil)}.to raise_error(RuntimeError, errmsg)
      end
    end

    context 'with an invalid value for onErrorMode' do
      it 'should throw an error' do
        errmsg = "Invalid argument specified. Operation apply_firmware_update"\
                 + " should have onErrorMode as : 'stopOnError' or"\
                 + " 'stopdeviceOnError' or 'continueOnError'"
        opts={"server"=>@server, "switch"=>@switch, "storage"=>@storage,
              "cmm"=>@cmm}
        expect {@client.apply_firmware_update(opts, nil, nil,
                "dummy")}.to raise_error(RuntimeError, errmsg)
      end
    end
  end

  describe 'PUT /updatableComponents positive cases' do
    context 'apply firmware updates with default values for activationMode,'\
            + ' forceUpdateMode and onErrorMode' do
      it 'applies firmware updates' do
        opts={"server"=>@server, "switch"=>@switch, "storage"=>@storage,
              "cmm"=>@cmm}
        @client.apply_firmware_update(opts, nil, nil, nil)
        uri = "#{@host}/updatableComponents?action=apply"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},"\
                                    + "#{storage_json},#{cmm_json}]}"

        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}"\
                     + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => apply_json,
              :headers => {'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip,deflate',
              'Authorization'=> 'Basic Og==',
              'Content-Type'=>'application/json',
              'User-Agent'=>user_agent})).to have_been_made
      end
    end

    context 'apply firmware updates with activationMode set to delayed and'\
            + 'default values for forceUpdateMode and onErrorMode' do
      it 'applies firmware updates' do
        opts={"server"=>@server, "switch"=>@switch, "storage"=>@storage,
              "cmm"=>@cmm}
        @client.apply_firmware_update(opts, "delayed", nil, nil)
        uri = "#{@host}/updatableComponents?action=apply&activationMode=delayed"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},"\
                                    + "#{storage_json},#{cmm_json}]}"

        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}"\
                     + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => apply_json,
             :headers => {'Accept'=>'*/*',
             'Accept-Encoding'=>'gzip,deflate',
             'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json',
             'User-Agent'=>user_agent})).to have_been_made
      end
    end

    context 'apply firmware updates with forceUpdateMode set to true and'\
            + ' default values for activationMode and onErrorMode' do
      it 'applies firmware updates' do
        opts={"server"=>@server, "switch"=>@switch, "storage"=>@storage,
              "cmm"=>@cmm}
        @client.apply_firmware_update(opts, nil, "true", nil)
        uri = "#{@host}/updatableComponents?action=apply&forceUpdateMode=true"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},"\
                                    + "#{storage_json},#{cmm_json}]}"

        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}"\
                     + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => apply_json,
              :headers => {'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip,deflate',
              'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json',
              'User-Agent'=>user_agent})).to have_been_made
      end
    end

    context 'apply firmware updates with onErrorMode set to stopOnError'\
            + ' and default values for activationMode and forceUpdateMode' do
      it 'applies firmware updates' do
        opts={"server"=>@server, "switch"=>@switch, "storage"=>@storage,
              "cmm"=>@cmm}
        @client.apply_firmware_update(opts, nil, nil, "stopOnError")
        uri = "#{@host}/updatableComponents?action=apply&onErrorMode="\
              + "stopOnError"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},"\
                     + "#{storage_json},#{cmm_json}]}"

        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}"\
                     + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => apply_json,
              :headers => {'Accept'=>'*/*',
              'Accept-Encoding'=>'gzip,deflate',
              'Authorization'=>'Basic Og==', 'Content-Type'=>'application/json',
              'User-Agent'=>user_agent})).to have_been_made
      end
    end

    context 'apply firmware updates with onErrorMode set'\
            + ' to continueOnError and default values for activationMode'\
            + ' and forceUpdateMode' do
      it 'applies firmware updates' do
        opts={"server"=>@server, "switch"=>@switch, "storage"=>@storage,
              "cmm"=>@cmm}
        @client.apply_firmware_update(opts, nil, nil, "continueOnError")
        uri = "#{@host}/updatableComponents?action=apply&onErrorMode"\
              + "=continueOnError"

        server_json = JSON.generate(:ServerList => @server)
        switch_json = JSON.generate(:SwitchList => @switch)
        storage_json = JSON.generate(:StorageList => @storage)
        cmm_json = JSON.generate(:CMMList => @cmm)

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},"\
                     + "#{storage_json},#{cmm_json}]}"

        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}"\
                     + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => apply_json,
               :headers => {'Accept'=>'*/*',
               'Accept-Encoding'=>'gzip,deflate',
               'Authorization'=>'Basic Og==',
               'Content-Type'=>'application/json',
               'User-Agent'=>user_agent})).to have_been_made
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

        apply_json = "{\"DeviceList\": [#{server_json},#{switch_json},"\
                     + "#{storage_json},#{cmm_json}]}"

        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}"\
                     + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => apply_json,
               :headers => {'Accept'=>'*/*',
               'Accept-Encoding'=>'gzip,deflate',
               'Authorization'=>'Basic Og==',
               'Content-Type'=>'application/json',
               'User-Agent'=>user_agent})).to have_been_made
      end
    end

    context 'modify power state' do
      it 'modifies power state' do
        @client.modify_power_state(@power_state_server, @power_state_switch,
                                   @power_state_storage, @power_state_cmm)
        uri = "#{@host}/updatableComponents?action=powerState"

        power_state_server_json = JSON.generate(:ServerList =>
                                                @power_state_server)
        power_state_switch_json = JSON.generate(:SwitchList =>
                                                @power_state_switch)
        power_state_storage_json = JSON.generate(:StorageList =>
                                                 @power_state_storage)
        power_state_cmm_json = JSON.generate(:CMMList => @power_state_cmm)

        apply_json = "{\"DeviceList\": [#{power_state_server_json},"\
                     + "#{power_state_switch_json},"\
                     + "#{power_state_storage_json},#{power_state_cmm_json}]}"

        user_agent = "LXCA via Ruby Client/#{XClarityClient::VERSION}"\
                     + (@user_agent.nil? ? "" : " (#{@user_agent})")
        expect(a_request(:put, uri).with(:body => apply_json,
               :headers => {'Accept'=>'*/*',
               'Accept-Encoding'=>'gzip,deflate',
               'Authorization'=>'Basic Og==',
               'Content-Type'=>'application/json',
               'User-Agent'=>user_agent})).to have_been_made
      end
    end
  end
end
