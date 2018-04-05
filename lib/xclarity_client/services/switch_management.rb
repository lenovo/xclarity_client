module XClarityClient
  class SwitchManagement< Services::XClarityService
    manages_endpoint Switch

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
