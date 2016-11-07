require 'json'
require 'uuid'

module XClarityClient
  class NodeManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Node::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(Node, opts)
    end

  end
end
