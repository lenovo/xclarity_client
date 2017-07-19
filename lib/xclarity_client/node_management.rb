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

    def set_node_power_state(uuid, requested_state = nil)
      if [uuid, requested_state].any? { |item| item.nil? }
        error = 'Invalid target or power state requested'
        $lxca_log.info 'XclarityClient::NodeManagement set_node_power_state', error
        raise ArgumentError, error
      end

      power_request = JSON.generate(powerState: requested_state) 
      response = do_put(Node::BASE_URI + '/' + uuid, power_request)
      $lxca_log.info 'XclarityClient::NodeManagement set_node_power_state', "Power state action has been sent with request #{power_request}"
      response
    end

    def set_loc_led_state(uuid, state, name = 'Identify')
      request = JSON.generate(leds:  [{ name: name, state: state }])

      $lxca_log.info "XclarityClient::ManagementMixin set_loc_led_state", "Loc led state action has been sent"

      do_put("#{Node::BASE_URI}/#{uuid}", request)
    end
  end
end
