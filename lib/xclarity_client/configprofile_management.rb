require 'json'

module XClarityClient
  class ConfigprofileManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Configprofile::BASE_URI)
    end

    def population()
      get_all_resources(Configprofile)
    end

    def rename_configprofile(id='', name='')
      renameReq = JSON.generate(profileName: name)
      response = do_put(Configprofile::BASE_URI + '/' +id, renameReq)
      puts response.body
    end

    def activate_configprofile(id='', endpoint_uuid='', restart='')
      postReq = JSON.generate(restart: restart, uuid: endpoint_uuid)
      response = do_post(Configprofile::BASE_URI + '/' +id, postReq)
      puts response.body
    end

    def unassign_configprofile(id='', force='',powerDown='',resetImm='')
      unassignReq = JSON.generate(force: force, powerDownITE: powerDown, resetIMM: resetImm)
      response = do_post(Configprofile::BASE_URI + '/unassign/' +id, unassignReq)
      puts response.body
    end

    def delete_configprofile(id='')
      response = do_delete(Configprofile::BASE_URI + '/' + id)
      puts response.body
    end

  end
end

