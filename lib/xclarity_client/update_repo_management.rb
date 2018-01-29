require 'json'

module XClarityClient
  class UpdateRepoManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, UpdateRepo::BASE_URI)
    end

    def population(opts = {})
      raise "Option key must be provided for update_repo resource" if opts.empty?
      raise "Option key must be provided for update_repo resource" if not (opts.has_key?(:key) || opts.has_key?("key"))
      repoKey = opts[:key] || opts["key"]
      if repoKey == "supportedMts" || repoKey == "size" || repoKey == "lastRefreshed" || repoKey == "importDir" || repoKey == "publicKeys" || repoKey == "updates" || repoKey == "updatesByMt" || repoKey == "updatesByMtByComp"
        get_all_resources(UpdateRepo, opts)
      else 
        raise "The value for option key should be one of these : supportedMts, lastRefreshed, size, importDir, publicKeys, updates, updatesByMt, updatesByMtByComp"
      end
    end

    def read_update_repo()
      response = do_put(UpdateRepo::BASE_URI + '?action=read')
      puts response.body 
    end
     
    def refresh_update_repo(scope, mt, os)
      if !scope.downcase.eql? "all" and !scope.downcase.eql? "latest"
        raise "Invalid argument combination of action and scope. Action refresh can have scope as either all or latest"
      end

      refresh_req = JSON.generate(mt: mt, os: os, type: "catalog") 
      response = do_put(UpdateRepo::BASE_URI + '?action=refresh&with=' +scope.downcase, refresh_req)
      puts response.body
    end
    
    def acquire_firmware_updates(scope, fixids, mt)
      if !scope.downcase.eql? "payloads"
        raise "Invalid argument combination of action and scope. Action acquire can have scope as payloads"
      end

      acquire_req = JSON.generate(mt: mt, fixids: fixids, type: "latest")
      response = do_put(UpdateRepo::BASE_URI + '?action=acquire&with=' +scope.downcase, acquire_req)
      puts response.body
    end
    
    def delete_firmware_updates(file_types, fixids)
      if !file_types.downcase.eql? "payloads" and !file_types.downcase.eql? "all"
        raise "Invalid value for argument file_types. Allowed values are - all and payloads"
      end

      delete_req = JSON.generate(fixids: fixids)
      response = do_put(UpdateRepo::BASE_URI + '?action=delete&filetypes=' +file_types.downcase, delete_req)
      puts response.body
    end

    def export_firmware_updates(file_types, fixids)
      if !file_types.downcase.eql? "payloads" and !file_types.downcase.eql? "all"
        raise "Invalid value for argument file_types. Allowed values are - all and payloads"
      end

      export_req = JSON.generate(fixids: fixids)
      response = do_put(UpdateRepo::BASE_URI + '?action=export&filetypes=' +file_types.downcase, export_req)
      puts response.body
    end

  end
end
