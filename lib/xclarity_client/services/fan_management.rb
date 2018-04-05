module XClarityClient
  class FanManagement < Services::XClarityService
    manages_endpoint Fan

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
