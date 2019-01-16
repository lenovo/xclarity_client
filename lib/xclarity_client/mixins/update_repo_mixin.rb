module XClarityClient
  #
  # Exposes UpdateRepoManagement features
  #
  module Mixins::UpdateRepoMixin
    def discover_update_repo(opts = {})
      UpdateRepoManagement.new(@config).fetch_all(opts)
    end

    def read_update_repo
      UpdateRepoManagement.new(@config).read_update_repo
    end

    def refresh_update_repo_catalog(scope, mt)
      msg = 'Invalid input: parameter mt should be Array of strings'
      raise msg unless mt.kind_of?(Array)
      UpdateRepoManagement.new(@config).refresh_update_repo_catalog(scope, mt)
    end

    def refresh_uxsp_update_repo_catalog(scope, mt)
      msg = 'Invalid input: parameter mt should be Array of strings'
      raise msg unless mt.kind_of?(Array)
      UpdateRepoManagement.new(@config).refresh_uxsp_update_repo_catalog(scope,
                                                                         mt)
    end

    def updates_info_by_machine_types(mt)
      msg = 'Invalid input: parameter mt should be Array of strings'
      raise msg unless mt.kind_of?(Array)
      UpdateRepoManagement.new(@config).updates_info_by_machine_types(mt)
    end

    def uxsp_updates_info_by_machine_types(mt)
      msg = 'Invalid input: parameter mt should Array of strings'
      raise msg unless mt.kind_of?(Array)
      UpdateRepoManagement.new(@config).uxsp_updates_info_by_machine_types(mt)
    end

    def acquire_firmware_updates(mt, fixids)
      msg = 'Invalid input: parameter mt & fixids should be of type Array'
      raise msg unless mt.kind_of?(Array) || fixids.kind_of?(Array)
      UpdateRepoManagement.new(@config).acquire_firmware_updates(mt, fixids)
    end

    def delete_firmware_updates(file_types, fixids = [])
      validate_inputs(file_types, fixids)
      UpdateRepoManagement.new(@config).delete_firmware_updates(file_types,
                                                                fixids)
    end

    def export_firmware_updates(file_types, fixids = [])
      validate_inputs(file_types, fixids)
      UpdateRepoManagement.new(@config).export_firmware_updates(file_types,
                                                                fixids)
    end

    def download_exported_firmware_updates(file_name, dir_path_for_download)
      dir = dir_path_for_download
      validate_file_name_dir_path(file_name, dir)
      UpdateRepoManagement.new(@config)
                          .download_exported_firmware_updates(file_name, dir)
    end

    def validate_import_updates(opts = {})
      UpdateRepoManagement.new(@config).validate_import_updates(opts)
    end

    def import_firmware_updates(opts = {})
      UpdateRepoManagement.new(@config).import_firmware_updates(opts)
    end

    def track_task_status(taskid, tasktype)
      UpdateRepoManagement.new(@config).track_task_status(taskid, tasktype)
    end

    def supported_machine_types_detail
      UpdateRepoManagement.new(@config).supported_machine_types_detail
    end

    def retrieve_compliance_policy_list
      UpdateRepoManagement.new(@config).retrieve_compliance_policy_list
    end

    def export_compliance_policies(policy_names)
      msg = 'Invalid input: parameter policy_names should be of type Array'
      raise msg unless policy_names.kind_of?(Array)
      UpdateRepoManagement.new(@config).export_compliance_policies(policy_names)
    end

    def download_exported_compliance_policies(file_name, dir_path_for_download)
      dir = dir_path_for_download
      validate_file_name_dir_path(file_name, dir)
      UpdateRepoManagement.new(@config)\
                          .download_exported_compliance_policies(file_name, dir)
    end

    def import_compliance_policies(opts = {})
      UpdateRepoManagement.new(@config).import_compliance_policies(opts)
    end

    private

    def validate_inputs(file_types, fixids)
      msg = 'Invalid value for argument file_types. Allowed values are'\
               + ' - all and payloads'
      raise msg unless %w(payloads all).include?(file_types)
      msg = 'Invalid input-> parameter fixids should be of type Array'
      raise msg unless fixids.kind_of?(Array)
      raise msg if file_types == 'payloads' && !fixids.any?
    end

    def validate_file_name_dir_path(file_name, dir_path_for_download)
      msg = 'Invalid input: parameter file_name and dir_path_for_download,'\
             + 'should be of type String'
      raise msg unless file_name.kind_of?(String)
      dir = dir_path_for_download
      msg = dir + ' directory doesnt exists'
      raise msg unless File.directory?(dir)
    end
  end
end
