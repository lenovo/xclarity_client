require 'json'
require 'uuid'

# XClarityClient module/namespace
module XClarityClient
  # Node Management class
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
        source = 'XClarity::NodeManagement set_node_power_state'
        $lxca_log.info source, error
        raise ArgumentError, error
      end

      send_power_request(Node::BASE_URI + '/' + uuid, requested_state)
    end

    def set_bmc_power_state(uuid, requested_state = nil)
      if [uuid, requested_state].any? { |item| item.nil? }
        error = 'Invalid target or power state requested'
        source = 'XClarity::NodeManagement set_bmc_power_state'
        $lxca_log.info source, error
        raise ArgumentError, error
      end

      send_power_request(Node::BASE_URI + '/' + uuid + '/bmc', requested_state)
    end

    def set_loc_led_state(uuid, state, name = 'Identify')
      request = JSON.generate(leds:  [{ name: name, state: state }])

      $lxca_log.info "XclarityClient::ManagementMixin set_loc_led_state", "Loc led state action has been sent"

      do_put("#{Node::BASE_URI}/#{uuid}", request)
    end

    private

    def send_power_request(uri, requested_state = nil)
      power_request = JSON.generate(powerState: requested_state)
      response = do_put(uri, power_request)
      msg = "Power state action has been sent with request #{power_request}"

      $lxca_log.info 'XclarityClient::NodeManagement set_node_power_state', msg
      response
    end
  end
end
