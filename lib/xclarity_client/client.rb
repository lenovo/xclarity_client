module XClarityClient
  class Client
    include XClarityClient::PowerManagementMixin

    def initialize(config)
      @config = config
    end

    def discover_nodes(opts = {})
      NodeManagement.new(@config).fetch_all(opts)
    end

    def discover_aicc(opts = {})
      AiccManagement.new(@config).fetch_all(opts)
    end

    def discover_scalableComplexes(opts = {})
      ScalableComplexManagement.new(@config).fetch_all(opts)
    end

    def discover_cabinet(opts = {})
      CabinetManagement.new(@config).fetch_all(opts)
    end

    def fetch_cabinet(uuids = nil,
                      includeAttributes = nil,
                      excludeAttributes = nil)
      CabinetManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def discover_canisters(opts = {})
      CanisterManagement.new(@config).fetch_all(opts)
    end

    def fetch_canisters(uuids = nil,
                        includeAttributes = nil,
                        excludeAttributes = nil)
      CanisterManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def discover_cmms(opts = {})
      CmmManagement.new(@config).fetch_all(opts)
    end

    def fetch_cmms(uuids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      CmmManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def fetch_fans(uuids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      FanManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def discover_fans(opts = {})
      FanManagement.new(@config).fetch_all(opts)
    end

    def discover_switches(opts = {})
      SwitchManagement.new(@config).fetch_all(opts)
    end

    def discover_storages(opts = {})
      StorageManagement.new(@config).fetch_all(opts)
    end

    def discover_fan_muxes(opts = {})
      FanMuxManagement.new(@config).fetch_all(opts)
    end

    def fetch_fan_muxes(uuids = nil,
                        includeAttributes = nil,
                        excludeAttributes = nil)
      FanMuxManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def discover_chassis(opts = {})
      ChassiManagement.new(@config).fetch_all(opts)
    end

    def discover_power_supplies(opts = {})
      PowerSupplyManagement.new(@config).fetch_all(opts)
    end

    def fetch_nodes(uuids = nil,
                    includeAttributes = nil,
                    excludeAttributes = nil)
      NodeManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def fetch_chassis(uuids = nil,
                      includeAttributes = nil,
                      excludeAttributes = nil)
      ChassiManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def fetch_scalableComplexes(uuids = nil,
                                includeAttributes = nil,
                                excludeAttributes = nil)
      ScalableComplexManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def fetch_switches(uuids = nil,
                       includeAttributes = nil,
                       excludeAttributes = nil)
      SwitchManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def fetch_storages(uuids = nil,
                       include_attributes = nil,
                       exclude_attributes = nil)
      StorageManagement.new(@config).get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end

    def fetch_power_supplies(uuids = nil,
                             includeAttributes = nil,
                             excludeAttributes = nil)
      PowerSupplyManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def discover_events
      EventManagement.new(@config).fetch_all
    end

    def fetch_events(opts = {})
      EventManagement.new(@config).get_object_with_opts(opts, Event)
    end

    def blink_loc_led(uuid = '')
      NodeManagement.new(@config).set_loc_led_state(uuid, 'Blinking')
    end

    def turn_on_loc_led(uuid = '')
      NodeManagement.new(@config).set_loc_led_state(uuid, 'On')
    end

    def turn_off_loc_led(uuid = '')
      NodeManagement.new(@config).set_loc_led_state(uuid, 'Off')
    end

    def fetch_ffdc(uuids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      FfdcManagement.new(@config).get_object(
        uuids,
        includeAttributes,
        excludeAttributes
      )
    end

    def discover_jobs(opts = {})
      JobManagement.new(@config).fetch_all(opts)
    end

    def fetch_jobs(ids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      JobManagement.new(@config).get_object_with_id(
        ids,
        includeAttributes,
        excludeAttributes
      )
    end

    def cancel_job(id = '')
      JobManagement.new(@config).cancel_job(id)
    end

    def delete_job(id = '')
      JobManagement.new(@config).delete_job(id)
    end

    def get_job(job_id = "")
        JobManagement.new(@config).get_job(job_id)
    end

    def discover_update_repo(opts = {})
      UpdateRepoManagement.new(@config).fetch_all(opts)
    end

    def discover_users(opts = {})
      UserManagement.new(@config).fetch_all
    end

    def fetch_users(ids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      UserManagement.new(@config).get_object_with_id(
        ids,
        includeAttributes,
        excludeAttributes
      )
    end

    def change_user_password(current_password, new_password)
      UserManagement.new(@config).change_password(current_password, new_password)
    end

    def fetch_config_target(ids=nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      ConfigTargetManagement.new(@config).get_object_with_id(
        ids,
        includeAttributes,
        excludeAttributes
      )
    end

    def fetch_config_profile(ids=nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      ConfigProfileManagement.new(@config).get_object_with_id(
        ids,
        includeAttributes,
        excludeAttributes
      )
    end

    def discover_config_profile
      ConfigProfileManagement.new(@config).fetch_all
    end

    def rename_config_profile(id='', name='')
      ConfigProfileManagement.new(@config).rename_config_profile(
        id,
        name
      )
    end

    def activate_config_profile(id='', endpoint_uuid='', restart='')
      ConfigProfileManagement.new(@config).activate_config_profile(
        id,
        endpoint_uuid,
        restart
      )
    end

    def unassign_config_profile(id='', powerDown='',resetImm='',force='')
      ConfigProfileManagement.new(@config).unassign_config_profile(
        id,
        powerDown,
        resetImm,
        force
      )
    end

    def delete_config_profile(id='')
      ConfigProfileManagement.new(@config).delete_config_profile(id)
    end

    def fetch_config_pattern(ids=nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      ConfigPatternManagement.new(@config).get_object_with_id(
        ids,
        includeAttributes,
        excludeAttributes
      )
    end

    def discover_config_pattern
      ConfigPatternManagement.new(@config).fetch_all
    end

    def export_config_pattern(id='')
      ConfigPatternManagement.new(@config).export(id)
    end

    def deploy_config_pattern(id='',endpoints=nil,restart='',etype='')
      ConfigPatternManagement.new(@config).deploy_config_pattern(
        id,
        endpoints,
        restart,
        etype
      )
    end

    def import_config_pattern(config_pattern = {})
      ConfigPatternManagement.new(@config).import_config_pattern(config_pattern)
    end

    def validate_configuration
      XClarityCredentialsValidator.new(@config).validate
    end

    def discover_manageable_devices(ip_addresses)
      DiscoverRequestManagement.new(@config).discover_manageable_devices(ip_addresses)
    end

    def discover_devices_by_slp
      DiscoveryManagement.new(@config).fetch_all
    end

    def monitor_discover_request(job_id)
      DiscoverRequestManagement.new(@config).monitor_discover_request(job_id)
    end

    def fetch_unmanage_request(job_id)
      UnmanageRequestManagement.new(@config).fetch_unmanage_request(job_id)
    end

    def unmanage_discovered_devices(endpoints, force)
      UnmanageRequestManagement.new(@config).unmanage_discovered_devices(endpoints, force)
    end

    def fetch_compliance_policies
      PersistedResultManagement.new(@config).fetch_all
    end

    def remote_control(uuid)
      RemoteAccessManagement.new(@config).remote_control(uuid)
    end

    def get_remotefileserver_profiles
      RemoteFileServerManagement.new(@config).population
    end

    def create_remotefileserver_profile(opts = {})
      RemoteFileServerManagement.new(@config).create_remotefileserver_profile(opts)
    end

    def delete_remotefileserver_profile(serverId = "")
      RemoteFileServerManagement.new(@config).delete_remotefileserver_profile(serverId)
    end

    def get_remotefileserver_profile(serverId = "")
      RemoteFileServerManagement.new(@config).get_remotefileserver_profile(serverId)
    end

    def import_osimage(serverId = "", path = "")
      OsImageManagement.new(@config).import_osimage(serverId, path)
    end

    def get_osimages
        OsImageManagement.new(@config).population
    end

    def get_hostplatforms
      HostPlatformManagement.new(@config).population
    end

    def get_osimage_deployment_status(uuid = "")
      HostPlatformManagement.new(@config).get_osimage_deployment_status(uuid)
    end

    def deploy_osimage(opts = [])
      HostPlatformManagement.new(@config).deploy_osimage(opts)
    end

    def get_globalsettings
      GlobalSettingManagement.new(@config).population
    end

    def set_globalsettings(opts = {})
      GlobalSettingManagement.new(@config).set_globalsettings(opts)
    end

    def discover_update_policy(opts = {})
      CompliancePolicyManagement.new(@config).fetch_all(opts)
    end

    def discover_application_firmware
      CompliancePolicyManagement.new(@config).get_applicable_firmware
    end

    def discover_persisted_compare_results(opts = {})
      CompliancePolicyManagement.new(@config).get_persisted_compare_results(opts)
    end

    def discover_compare_results(opts = {})
      CompliancePolicyManagement.new(@config).get_compare_results(opts)
    end

    def assign_compliance_policy(opts = {}, keep=nil, auto_assign=nil)
      CompliancePolicyManagement.new(@config).assign_compliance_policy(opts, keep, auto_assign)
    end

    def delete_compliance_policy(policyName, removePackage=nil)
      CompliancePolicyManagement.new(@config).delete_compliance_policy(policyName, removePackage)
    end
  end
end
