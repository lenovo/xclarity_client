require 'json'

module XClarityClient
  class ScalableComplexManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, ScalableComplex::BASE_URI)
    end

    def population
      get_all_resources(ScalableComplex)
    end

  end
end
