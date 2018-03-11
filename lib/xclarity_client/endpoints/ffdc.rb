module XClarityClient
  class Ffdc < Endpoints::XclarityEndpoint
    BASE_URI = '/ffdc/endpoint'.freeze
    LIST_NAME = 'ffdcList'.freeze

    attr_accessor :jobURL
  end
end
