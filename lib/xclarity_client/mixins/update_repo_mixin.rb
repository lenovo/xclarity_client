module XClarityClient
  #
  # Exposes UpdateRepoManagement features
  #
  module Mixins::UpdateRepoMixin
    def discover_update_repo(opts = {})
      UpdateRepoManagement.new(@config).fetch_all(opts)
    end
  end
end
