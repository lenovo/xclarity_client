module XClarityClient
  class Ffdc
    include XClarityClient::Resource

    BASE_URI = '/ffdc/endpoint'.freeze
    LIST_NAME = 'ffdcList'.freeze

    attr_accessor :jobURL

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
