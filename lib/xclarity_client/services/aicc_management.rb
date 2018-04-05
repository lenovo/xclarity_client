module XClarityClient
  class AiccManagement < Services::XClarityService
    manages_endpoint Aicc

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
