module XClarityClient
  class Client
    include XClarityClient::PowerManagementMixin

    def initialize(connection)
      @connection = connection
    end

    def discover_nodes(opts = {})
      NodeManagement.new(@connection).population opts
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

    def fetch_configtarget(ids=nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      ConfigtargetManagement.new(@connection).get_object_with_id(ids, 
                                                        includeAttributes, 
                                                        excludeAttributes,
                                                        Configtarget)
    end

    def fetch_configprofile(ids=nil, 
                   includeAttributes = nil,
                   excludeAttributes = nil)
      ConfigprofileManagement.new(@connection).get_object_with_id(ids, 
                                                        includeAttributes,
                                                        excludeAttributes,
                                                        Configprofile)
    end

    def discover_configprofile
      ConfigprofileManagement.new(@connection).population
    end

    def rename_configprofile(id='', name='')
      ConfigprofileManagement.new(@connection).rename_configprofile(id,
						      name)
    end
  
    def activate_configprofile(id='', endpoint_uuid='', restart='')
      ConfigprofileManagement.new(@connection).activate_configprofile(id,
							endpoint_uuid,
							restart)
    end

    def unassign_configprofile(id='', powerDown='',resetImm='',force='')
      ConfigprofileManagement.new(@connection).unassign_configprofile(id,
							powerDown,
							resetImm,
							force)
    end

    def delete_configprofile(id='')
      ConfigprofileManagement.new(@connection).delete_configprofile(id)
    end
  
    def fetch_configpattern(ids=nil,
                   includeAttributes = nil,
                   excludeAttributes = nil)
      ConfigpatternManagement.new(@connection).get_object_with_id(ids,
                                                        includeAttributes,
                                                        excludeAttributes,
                                                        Configpattern)
    end

    def discover_configpattern
      ConfigpatternManagement.new(@connection).population
    end
 
    def export_configpattern(id='')
      ConfigpatternManagement.new(@connection).export(id)
    end   

    def deploy_configpattern(id='',endpoints=nil,restart='',etype='')
      ConfigpatternManagement.new(@connection).deploy_configpattern(id,
						      endpoints,
                                                      restart,
                                                      etype)
    end
   
    def import_configpattern(configpattern = {})
      ConfigpatternManagement.new(@connection).import_configpattern(configpattern)
    end

  end
end
