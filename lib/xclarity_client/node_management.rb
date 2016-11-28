require 'json'
require 'uuid'

module XClarityClient
  class NodeManagement < XClarityBase

     OFF = 1
    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Node::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(Node, opts)
    end

    def set_node_power_state (uuid, powerState= OFF)
      power_request = ''

      puts "UUID to shutdown " + uuid
      case powerState
      when OFF
        power_request = JSON.generate({:powerState =>"powerOff" })
      else
        power_request = JSON.generate({:powerState =>"powerOn"})
      end

      response = do_put(Node::BASE_URI + "/" + uuid, power_request)
    end

  end
end
