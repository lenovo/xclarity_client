require 'json'

module XClarityClient
  class ConfigProfileManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, ConfigProfile::BASE_URI)
    end

    def population()
      get_all_resources(ConfigProfile)
    end

    def rename_config_profile(id='', name='')
      renameReq = JSON.generate(profileName: name)
      response = do_put(ConfigProfile::BASE_URI + '/' +id, renameReq)
      response
    end

    def activate_config_profile(id='', endpoint_uuid='', restart='')
      postReq = JSON.generate(restart: restart, uuid: endpoint_uuid)
      response = do_post(ConfigProfile::BASE_URI + '/' +id, postReq)
      response
    end

    def unassign_config_profile(id='', force='',powerDown='',resetImm='')
      unassignReq = JSON.generate(force: force, powerDownITE: powerDown, resetIMM: resetImm)
      response = do_post(ConfigProfile::BASE_URI + '/unassign/' +id, unassignReq)
      response
    end

    def delete_config_profile(id='')
      response = do_delete(ConfigProfile::BASE_URI + '/' + id)
      response
    end

  end
end

