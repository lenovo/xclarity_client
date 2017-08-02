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

  end
end
