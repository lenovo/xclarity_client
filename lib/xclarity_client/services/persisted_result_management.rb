require 'json'

module XClarityClient
  class PersistedResultManagement < Services::XClarityService
    manages_endpoint PersistedResult

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
