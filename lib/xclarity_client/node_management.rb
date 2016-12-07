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

    def set_node_power_state (uuid, requestedState)
      power_request = ''

      puts "UUID to "  + requestedState + ": " + requestedState
      powerRequest = JSON.generate({:powerState => requestedState})
      response = do_put(Node::BASE_URI + "/" + uuid, powerRequest)
    end

  end
end
