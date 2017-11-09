module XClarityClient
  class Client
    include XClarityClient::PowerManagementMixin

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes(opts = {})
      NodeManagement.new(@connection).population opts
    end

    def discover_aicc(opts = {})
      AiccManagement.new(@connection).population opts
    end

    def discover_scalableComplexes(opts = {})
      ScalableComplexManagement.new(@connection).population opts
    end

    def discover_cabinet(opts = {})
      CabinetManagement.new(@connection).population opts
    end

    def fetch_cabinet(uuids = nil,
                      includeAttributes = nil,
                      excludeAttributes = nil)
      CabinetManagement.new(@connection).get_object(uuids,
                                                    includeAttributes,
                                                    excludeAttributes,
                                                    Cabinet)
    end

    def discover_canisters(opts = {})
      CanisterManagement.new(@connection).population opts
    end

    def fetch_canisters(uuids = nil,
                        includeAttributes = nil,
                        excludeAttributes = nil)
      CanisterManagement.new(@connection).get_object(uuids,
                                                     includeAttributes,
                                                     excludeAttributes,
                                                     Canister)
    end

    def discover_cmms(opts = {})
      CmmManagement.new(@connection).population opts
    end

    def fetch_cmms(uuids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      CmmManagement.new(@connection).get_object(uuids,
                                                includeAttributes,
                                                excludeAttributes,
                                                Cmm)
    end

    def fetch_fans(uuids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      FanManagement.new(@connection).get_object(uuids,
                                                includeAttributes,
                                                excludeAttributes,
                                                Fan)
    end

    def discover_fans(opts = {})
      FanManagement.new(@connection).population opts
    end

    def discover_switches(opts = {})
      SwitchManagement.new(@connection).population opts
    end

    def discover_fan_muxes(opts = {})
      FanMuxManagement.new(@connection).population opts
    end

    def fetch_fan_muxes(uuids = nil,
                        includeAttributes = nil,
                        excludeAttributes = nil)
      FanMuxManagement.new(@connection).get_object(uuids,
                                                   includeAttributes,
                                                   excludeAttributes,
                                                   FanMux)
    end

    def discover_chassis(opts = {})
      ChassiManagement.new(@connection).population opts
    end

    def discover_power_supplies(opts = {})
      PowerSupplyManagement.new(@connection).population opts
    end

    def fetch_nodes(uuids = nil,
                    includeAttributes = nil,
                    excludeAttributes = nil)
      NodeManagement.new(@connection).get_object(uuids,
                                                 includeAttributes,
                                                 excludeAttributes,
                                                 Node)
    end

    def fetch_chassis(uuids = nil,
                      includeAttributes = nil,
                      excludeAttributes = nil)
      ChassiManagement.new(@connection).get_object(uuids,
                                                   includeAttributes,
                                                   excludeAttributes,
                                                   Chassi)
    end

    def fetch_scalableComplexes(uuids = nil,
                                includeAttributes = nil,
                                excludeAttributes = nil)
      ScalableComplexManagement.new(@connection).get_object(uuids,
                                                            includeAttributes,
                                                            excludeAttributes,
                                                            ScalableComplex)
    end

    def fetch_switches(uuids = nil,
                       includeAttributes = nil,
                       excludeAttributes = nil)
      SwitchManagement.new(@connection).get_object(uuids,
                                                   includeAttributes,
                                                   excludeAttributes,
                                                   Switch)
    end

    def fetch_power_supplies(uuids = nil,
                             includeAttributes = nil,
                             excludeAttributes = nil)
      PowerSupplyManagement.new(@connection).get_object(uuids,
                                                        includeAttributes,
                                                        excludeAttributes,
                                                        PowerSupply)
    end

    def discover_events
      EventManagement.new(@connection).population
    end

    def fetch_events(opts = {})
      EventManagement.new(@connection).get_object_with_opts(opts, Event)
    end

    def blink_loc_led(uuid = '')
      NodeManagement.new(@connection).set_loc_led_state(uuid, 'Blinking')
    end

    def turn_on_loc_led(uuid = '')
      NodeManagement.new(@connection).set_loc_led_state(uuid, 'On')
    end

    def turn_off_loc_led(uuid = '')
      NodeManagement.new(@connection).set_loc_led_state(uuid, 'Off')
    end
  
    def fetch_ffdc(uuids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      FfdcManagement.new(@connection).get_object(uuids,
                                                includeAttributes,
                                                excludeAttributes,
                                                Ffdc)
    end

    def discover_jobs(opts = {})
      JobManagement.new(@connection).population opts
    end

    def fetch_jobs(ids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      JobManagement.new(@connection).get_object_with_id(ids,
                                                includeAttributes,
                                                excludeAttributes,
                                                Job)
    end

    def cancel_job(id = '')
      JobManagement.new(@connection).cancel_job(id)
    end

    def delete_job(id = '')
      JobManagement.new(@connection).delete_job(id)
    end

    def discover_update_repo(opts = {})
      UpdateRepoManagement.new(@connection).population opts
    end

    def discover_users(opts = {})
      UserManagement.new(@connection).population
    end

    def fetch_users(ids = nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      UserManagement.new(@connection).get_object_with_id(ids,
                                                includeAttributes,
                                                excludeAttributes,
                                                User)
    end

    def fetch_config_target(ids=nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      ConfigTargetManagement.new(@connection).get_object_with_id(ids, 
                                                        includeAttributes, 
                                                        excludeAttributes,
                                                        ConfigTarget)
    end

    def fetch_config_profile(ids=nil, 
                   includeAttributes = nil,
                   excludeAttributes = nil)
      ConfigProfileManagement.new(@connection).get_object_with_id(ids, 
                                                        includeAttributes,
                                                        excludeAttributes,
                                                        ConfigProfile)
    end

    def discover_config_profile
      ConfigProfileManagement.new(@connection).population
    end

    def rename_config_profile(id='', name='')
      ConfigProfileManagement.new(@connection).rename_config_profile(id,
						      name)
    end
  
    def activate_config_profile(id='', endpoint_uuid='', restart='')
      ConfigProfileManagement.new(@connection).activate_config_profile(id,
							endpoint_uuid,
							restart)
    end

    def unassign_config_profile(id='', powerDown='',resetImm='',force='')
      ConfigProfileManagement.new(@connection).unassign_config_profile(id,
							powerDown,
							resetImm,
							force)
    end

    def delete_config_profile(id='')
      ConfigProfileManagement.new(@connection).delete_config_profile(id)
    end
  
    def fetch_config_pattern(ids=nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      ConfigPatternManagement.new(@connection).get_object_with_id(ids,
                                                        includeAttributes,
                                                        excludeAttributes,
                                                        ConfigPattern)
    end

    def discover_config_pattern
      ConfigPatternManagement.new(@connection).population
    end
 
    def export_config_pattern(id='')
      ConfigPatternManagement.new(@connection).export(id)
    end   

    def deploy_config_pattern(id='',endpoints=nil,restart='',etype='')
      ConfigPatternManagement.new(@connection).deploy_config_pattern(id,
						      endpoints,
                                                      restart,
                                                      etype)
    end
   
    def import_config_pattern(config_pattern = {})
      ConfigPatternManagement.new(@connection).import_config_pattern(config_pattern)
    end

    def validate_configuration
      XClarityCredentialsValidator.new(@connection).validate
    end

    def discover_manageable_devices(ip_addresses)
      DiscoverRequestManagement.new(@connection).discover_manageable_devices(ip_addresses)
    end

    def discover_devices_by_slp
      DiscoveryManagement.new(@connection).population

    def monitor_discover_request(job_id)
      DiscoverRequestManagement.new(@connection).monitor_discover_request(job_id)
    end

  end
end
