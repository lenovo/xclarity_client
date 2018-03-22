module XClarityClient
  class ScalableComplexManagement< Services::XClarityService
    manages_endpoint ScalableComplex

    def population(opts = {})
      fetch_all(opts)
    end
  end
end
