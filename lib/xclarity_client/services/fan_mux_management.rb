module XClarityClient
  class FanMuxManagement < Services::XClarityService
    manages_endpoint FanMux

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
