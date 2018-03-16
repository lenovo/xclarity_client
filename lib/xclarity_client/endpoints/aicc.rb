module XClarityClient
  class Aicc < Endpoints::XclarityEndpoint
    BASE_URI = '/aicc'.freeze
    LIST_NAME = 'aiccList'.freeze

    attr_accessor :appliance
  end
end
