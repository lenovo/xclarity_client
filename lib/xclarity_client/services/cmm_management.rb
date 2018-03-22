module XClarityClient
  class CmmManagement < Services::XClarityService
    manages_endpoint Cmm

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
