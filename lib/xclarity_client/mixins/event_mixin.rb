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

    def get_last_cn(opts = {})
      headers = EventManagement.new(@config).get_headers_with_opts(opts, Event)
      range = headers['content-range']
      range.slice(range.index('/') + 1, range.length).to_i
    end
  end
end
