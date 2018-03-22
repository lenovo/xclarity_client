module XClarityClient
  class DiscoveryManagement  < Services::XClarityService
    manages_endpoint Discovery

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
