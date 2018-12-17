module XClarityClient
  #
  # Exposes ManagementServerManagement features
  #
  module Mixins::ManagementServerMixin
    def get_management_server_updates_info(key = nil)
      obj = ManagementServerManagement.new(@config)
      obj.get_management_server_updates_info(key)
    end

    def delete_management_server_updates(fixids)
      return "parameter 'fixids' should be array" unless fixids.kind_of?(Array)
      obj = ManagementServerManagement.new(@config)
      obj.delete_management_server_updates(fixids)
    end

    def download_management_server_updates(fixids)
      return "parameter 'fixids' should be array" unless fixids.kind_of?(Array)
      obj = ManagementServerManagement.new(@config)
      obj.download_management_server_updates(fixids)
    end

    def apply_management_server_updates(fixids)
      return "parameter 'fixids' should be array" unless fixids.kind_of?(Array)
      obj = ManagementServerManagement.new(@config)
      obj.apply_management_server_updates(fixids)
    end

    def refresh_management_server_updates_catalog
      obj = ManagementServerManagement.new(@config)
      obj.refresh_management_server_updates_catalog
    end

    def import_management_server_updates(files)
      return "parameter 'files' should be array" unless files.kind_of?(Array)
      obj = ManagementServerManagement.new(@config)
      obj.import_management_server_updates(files)
    end
  end
end
