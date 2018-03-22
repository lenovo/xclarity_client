require 'json'

module XClarityClient
  class ConfigProfileManagement < Services::XClarityService
    manages_endpoint ConfigProfile

    def population(opts = {})
      fetch_all(opts)
    end

    def rename_config_profile(id='', name='')
      renameReq = JSON.generate(profileName: name)
      response = @connection.do_put(managed_resource::BASE_URI + '/' +id, renameReq)
      response
    end

    def activate_config_profile(id='', endpoint_uuid='', restart='')
      postReq = JSON.generate(restart: restart, uuid: endpoint_uuid)
      response = @connection.do_post(managed_resource::BASE_URI + '/' +id, postReq)
      response
    end

    def unassign_config_profile(id='', force='',powerDown='',resetImm='')
      unassignReq = JSON.generate(force: force, powerDownITE: powerDown, resetIMM: resetImm)
      response = @connection.do_post(managed_resource::BASE_URI + '/unassign/' +id, unassignReq)
      response
    end

    def delete_config_profile(id='')
      response = @connection.do_delete(managed_resource::BASE_URI + '/' + id)
      response
    end
  end
end

