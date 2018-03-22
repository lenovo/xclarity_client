module XClarityClient
  class UpdateRepoManagement < Services::XClarityService
    manages_endpoint UpdateRepo

    def population(opts = {})
      raise "Option key must be provided for update_repo resource" if opts.empty?
      raise "Option key must be provided for update_repo resource" if not (opts.has_key?(:key) || opts.has_key?("key"))
      repoKey = opts[:key] || opts["key"]
      if repoKey == "supportedMts" || repoKey == "size" || repoKey == "lastRefreshed" || repoKey == "importDir" || repoKey == "publicKeys" || repoKey == "updates" || repoKey == "updatesByMt" || repoKey == "updatesByMtByComp"
        fetch_all(opts)
      else
        raise "The value for option key should be one of these : supportedMts, lastRefreshed, size, importDir, publicKeys, updates, updatesByMt, updatesByMtByComp"
      end
    end
  end
end
