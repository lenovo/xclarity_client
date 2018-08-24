module XClarityClient
  class UpdateRepoManagement < Services::XClarityService
    manages_endpoint UpdateRepo

    def fetch_all(opts = {})
      validate_opts(opts)
      super(opts)
    end

    private

    def validate_opts(opts)
      err_missing_key = 'Option key must be provided for update_repo resource'
      err_wrong_key = 'The value for option key should be one of these : '\
        "#{allowed_keys.join(', ')}"

      raise err_missing_key if opts.empty? || !(opts[:key] || opts['key'])

      repo_key = opts[:key] || opts['key']

      raise err_wrong_key unless allowed_keys.include?(repo_key)
    end

    def allowed_keys
      %w(
        supportedMts
        size
        lastRefreshed
        importDir
        publicKeys
        updates
        updatesByMt
        updatesByMtByComp
      )
    end

    public

    def check_file_types(file_types)
      x = 'Invalid value for argument file_types. Allowed values are'\
               + ' - all and payloads'
      raise x unless file_types.casecmp('payloads').zero? ||
                     file_types.casecmp('all').zero?
    end

    def read_update_repo
      response = @connection.do_put(UpdateRepo::BASE_URI + '?action=read')
      response.body
    end

    def refresh_update_repo(scope, mt, os)
      if scope.casecmp('all') != 0 && scope.casecmp('latest') != 0
        raise 'Invalid argument combination of action and scope. Action'\
               + ' refresh can have scope as either all or latest'
      end
      refresh_req = JSON.generate(:mt => mt, :os => os, :type => 'catalog')
      response = @connection.do_put(UpdateRepo::BASE_URI\
                                    + '?action=refresh&with='\
                                    + scope.downcase, refresh_req)
      response.body
    end

    def acquire_firmware_updates(scope, fixids, mt)
      if scope.casecmp('payloads') != 0
        raise 'Invalid argument combination of action and scope. Action'\
               + ' acquire can have scope as payloads'
      end
      acquire_req = JSON.generate(:mt => mt, :fixids => fixids,
                                  :type => 'latest')
      response = @connection.do_put(UpdateRepo::BASE_URI\
                                    + '?action=acquire&with='\
                                    + scope.downcase, acquire_req)
      response.body
    end

    def delete_firmware_updates(file_types, fixids)
      check_file_types(file_types)
      delete_req = JSON.generate(:fixids => fixids)
      response = @connection.do_put(UpdateRepo::BASE_URI + '?action='\
                                    + 'delete&filetypes=' + file_types.downcase,
                                    delete_req)
      response.body
    end

    def export_firmware_updates(file_types, fixids)
      check_file_types(file_types)

      export_req = JSON.generate(:fixids => fixids)
      response = @connection.do_put(UpdateRepo::BASE_URI\
                                    + '?action=export&filetypes='\
                                    + file_types.downcase, export_req)
      response.body
    end
  end
end
