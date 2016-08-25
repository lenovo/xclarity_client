module XClarityClient
  class VirtualApplianceManagement < XClarityBase

    BASE_URI = '/aicc'

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def configuration_settings
      response = @conn.get
      response
    end

    def configuration_settings=
    end
  end
end
