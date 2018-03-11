require 'json'

module XClarityClient
  class ScalableComplexManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, ScalableComplex::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(ScalableComplex, opts)
    end

  end
end
