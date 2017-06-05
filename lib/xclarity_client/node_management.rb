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

    def set_node_power_state(uuid, powerState = OFF)
      puts 'UUID to shutdown ' + uuid
      power_request = case powerState
                      when OFF
                        JSON.generate(powerState: 'powerOff')
                      else
                        JSON.generate(powerState: 'powerOn')
                      end
      $lxca_log.info "XclarityClient::ManagementMixin set_node_power_state", "Power state action has been sent"

      do_put(Node::BASE_URI + '/' + uuid, power_request)
    end

    def set_loc_led_state(uuid, state, name = 'Identify')
      request = JSON.generate(leds:  [{ name: name, state: state }])

      $lxca_log.info "XclarityClient::ManagementMixin set_loc_led_state", "Loc led state action has been sent"

      do_put("#{Node::BASE_URI}/#{uuid}", request)
    end
  end
end
