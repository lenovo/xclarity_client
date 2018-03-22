module XClarityClient
  class CabinetManagement < Services::XClarityService
    manages_endpoint Cabinet

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
