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

    def track_task_status(taskid, tasktype)
      uri = UpdateRepo::BASE_URI + '/status' + '?tasktype=' + tasktype\
              + '&taskid=' + taskid.to_s
      @connection.do_get(uri)
    end

    def download_exported_firmware_updates(fname, dir_path_to_download)
      uri = UpdateRepo::BASE_URI + '?action=export&exportRepoFilename=' + fname
      file_path = File.join(dir_path_to_download, fname)
      @connection.do_get_file_download(uri, file_path)
    end

    def read_update_repo
      @connection.do_put(UpdateRepo::BASE_URI + '?action=read')
    end

    def refresh_update_repo_catalog(scope, mt, uxsp = false)
      unless %w(all latest).include?(scope)
        raise 'Invalid argument combination of action and scope. Action'\
               + ' refresh can have scope as either all or latest'
      end
      req_body = JSON.generate(:mt => mt, :os => '', :type => 'catalog')
      uri = UpdateRepo::BASE_URI
      uri += '/uxsps' if uxsp
      uri += '?action=refresh&with=' + scope
      @connection.do_put(uri, req_body)
    end

    def refresh_uxsp_update_repo_catalog(scope, mt)
      refresh_update_repo_catalog(scope, mt, true)
    end

    def updates_info_by_machine_types(mt, uxsp = false)
      mt = mt.join(',').to_str
      uri = UpdateRepo::BASE_URI
      uri += '/uxsps' if uxsp
      key = 'uxspsByMt' if uxsp
      key = 'updatesByMt' unless uxsp
      uri += '?key=' + key + '&with=all&payload&mt=' + mt
      @connection.do_get(uri)
    end

    def uxsp_updates_info_by_machine_types(mt)
      updates_info_by_machine_types(mt, true)
    end

    def supported_machine_types_detail
      @connection.do_get(UpdateRepo::BASE_URI + '?key=supportedMts')
    end

    def acquire_firmware_updates(mt, fixids)
      req_body = JSON.generate(:mt => mt, :fixids => fixids, :type => 'latest')
      @connection.do_put(UpdateRepo::BASE_URI\
               + '?action=acquire&with=payloads', req_body)
    end

    def delete_firmware_updates(file_types, fixids = [])
      req_body = JSON.generate(:fixids => fixids)
      @connection.do_put(UpdateRepo::BASE_URI + '?action='\
                         + 'delete&filetypes=' + file_types.downcase,
                         req_body)
    end

    def export_firmware_updates(file_types, fixids = [])
      req_body = JSON.generate(:fixids => fixids)
      @connection.do_put(UpdateRepo::BASE_URI\
                         + '?action=export&filetypes='\
                         + file_types.downcase, req_body)
    end

    def validate_import_updates(file_path)
      type = 'application/x-zip-compressed'
      fname = File.basename(file_path)
      opts = { :index => 0, :name => fname,
               :type  => type,
               :size  => File.size?(file_path) }
      req_body = JSON.generate(opts)
      uri = '/files/updateRepositories/firmware/import/validate'
      @connection.do_post(uri, req_body)
    end

    def import_firmware_updates(file_path)
      uri = '/files/updateRepositories/firmware/import'
      type = 'application/x-zip-compressed'
      opts = { :upload_file => Faraday::UploadIO.new(file_path, type) }
      @connection.do_post(uri, opts, true)
    end

    def retrieve_compliance_policy_list
      uri = '/compliancePolicies'
      @connection.do_get(uri)
    end

    def export_compliance_policies(policy_names)
      uri = '/compliancePolicies?action=export'
      req_body = JSON.generate(:export => policy_names)
      @connection.do_put(uri, req_body)
    end

    def download_exported_compliance_policies(fname, dir_path_for_download)
      uri = '/compliancePolicies?exportDownload=' + fname
      file_path = File.join(dir_path_for_download, fname)
      @connection.do_get_file_download(uri, file_path)
    end

    def import_compliance_policies(file_path)
      uri = '/files/compliancePolicies?action=import'
      type = 'application/x-zip-compressed'
      opts = { :upload_file => Faraday::UploadIO.new(file_path, type) }
      @connection.do_post(uri, opts, true)
    end
  end
end
