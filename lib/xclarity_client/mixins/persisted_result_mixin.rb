module XClarityClient
  #
  # Exposes PersistedResultManagement features
  #
  module Mixins::PersistedResultMixin
    def fetch_compliance_policies
      PersistedResultManagement.new(@config).fetch_all
    end
  end
end
