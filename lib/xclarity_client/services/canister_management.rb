module XClarityClient
  class CanisterManagement < Services::XClarityService
    manages_endpoint Canister

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
