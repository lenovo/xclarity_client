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

    def track_export_progress(jobid)
      progress = 0
      uri = UpdateRepo::BASE_URI + '/status' + '?tasktype=EXPORTREPOSITORY'\
              + '&taskid=' + jobid.to_s
      while progress < 100
        resp = @connection.do_get(uri, :query => {}, :headers => {},
                                  :n_http => true)
        return resp, 'error' if resp.nil? || resp.status != 200
        res = JSON.parse(resp.body)
        return resp, 'error' if res['state'] == 'error'
        progress = res['progress']
        sleep(30)
      end
      return resp, 'success'
    end

    def download_exported_file(jobid)
      resp, result = track_export_progress(jobid)
      return resp unless result == 'success'
      res = JSON.parse(resp.body)
      fname = res['current'].to_s
      uri = UpdateRepo::BASE_URI + '?action=export&exportRepoFilename=' + fname
      resp = @connection.do_get(uri, :query => {}, :headers => {},
                                :n_http => true)
      fp = File.open('./' + fname.to_s, 'wb')
      fp.write(resp.body)
      fp.close
    end

    def validate_inputs(file_types, fixids)
      msg = 'Invalid value for argument file_types. Allowed values are'\
               + ' - all and payloads'
      raise msg unless %w(payloads all).include?(file_types)
      msg = 'Invalid inputs when argument file_types has values payloads'\
             + ' argument fixids should not be nil'
      raise msg if file_types == 'payloads' && fixids.nil?
    end

    public

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

    def delete_firmware_updates(file_types, fixids = nil)
      validate_inputs(file_types, fixids)
      delete_req = JSON.generate(:fixids => fixids)
      response = @connection.do_put(UpdateRepo::BASE_URI + '?action='\
                                    + 'delete&filetypes=' + file_types.downcase,
                                    delete_req)
      response.body
    end

    def export_firmware_updates(file_types, fixids = nil)
      validate_inputs(file_types, fixids)
      export_req = JSON.generate(:fixids => fixids)
      resp = @connection.do_put(UpdateRepo::BASE_URI\
                                    + '?action=export&filetypes='\
                                    + file_types.downcase, export_req)
      return resp if resp.nil? || resp.status != 200
      res = JSON.parse(resp.body)
      jobid = res['taskid']
      $lxca_log.info(self.class.to_s + ' ' + __method__.to_s, "jobid: #{jobid}")
      download_exported_file(jobid)
    end
  end
end
