module XClarityClient
  class ConfigTargetManagement < Services::XClarityService
    manages_endpoint ConfigTarget

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
