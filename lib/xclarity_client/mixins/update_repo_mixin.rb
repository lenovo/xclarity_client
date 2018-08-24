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

    def refresh_update_repo(scope, mt, os)
      UpdateRepoManagement.new(@config).refresh_update_repo(scope, mt, os)
    end

    def acquire_firmware_updates(scope, fixids, mt)
      UpdateRepoManagement.new(@config).acquire_firmware_updates(scope,
                                                                 fixids, mt)
    end

    def delete_firmware_updates(file_types, fixids)
      UpdateRepoManagement.new(@config).delete_firmware_updates(file_types,
                                                                fixids)
    end

    def export_firmware_updates(file_types, fixids)
      UpdateRepoManagement.new(@config).export_firmware_updates(file_types,
                                                                fixids)
    end
  end
end
