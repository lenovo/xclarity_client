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
  end
end
