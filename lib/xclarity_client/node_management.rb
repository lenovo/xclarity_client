require 'json'
require 'uuid'

module XClarityClient
  class NodeManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Node::BASE_URI)
    end

    def population
      get_all_resources(Node)
    end

  end
end
