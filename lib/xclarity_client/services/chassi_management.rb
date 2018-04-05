module XClarityClient
  class ChassiManagement < Services::XClarityService
    manages_endpoint Chassi

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
