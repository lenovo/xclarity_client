require 'json'

module XClarityClient
  class EventManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Event::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(Event, opts)
    end

  end
end
