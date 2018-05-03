module XClarityClient
  #
  # Exposes EventManagement features
  #
  module Mixins::EventMixin
    def discover_events
      EventManagement.new(@config).fetch_all
    end

    def fetch_events(opts = {})
      EventManagement.new(@config).get_object_with_opts(opts, Event)
    end
  end
end
