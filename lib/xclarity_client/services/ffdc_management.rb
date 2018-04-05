module XClarityClient
  class FfdcManagement  < Services::XClarityService
    manages_endpoint Ffdc

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
