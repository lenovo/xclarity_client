module XClarityClient
  #
  # Exposes AiccManagement features
  #
  module Mixins::AiccMixin
    def discover_aicc(opts = {})
      AiccManagement.new(@config).fetch_all(opts)
    end
  end
end
