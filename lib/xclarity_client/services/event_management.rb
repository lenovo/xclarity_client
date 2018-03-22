module XClarityClient
  class EventManagement < Services::XClarityService
    manages_endpoint Event

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
