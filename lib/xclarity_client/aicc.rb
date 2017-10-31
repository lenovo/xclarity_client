module XClarityClient
  class Aicc
    include XClarityClient::Resource

    BASE_URI = '/aicc'.freeze
    LIST_NAME = 'aiccList'.freeze

    attr_accessor :appliance

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
