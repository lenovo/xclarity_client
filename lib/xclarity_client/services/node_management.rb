require 'json'
require 'uuid'
require 'xclarity_client/services/mixins/power_action_sender_mixin'

# XClarityClient module/namespace
module XClarityClient
  # Node Management class
  class NodeManagement < Services::XClarityService
    include Services::PowerActionSenderMixin

    manages_endpoint Node

    def set_bmc_power_state(uuid, requested_state = nil)
      if [uuid, requested_state].any? { |item| item.nil? }
        error = 'Invalid target or power state requested'
        source = 'XClarity::NodeManagement set_bmc_power_state'
        $lxca_log.info source, error
        raise ArgumentError, error
      end

      send_power_request(managed_resource::BASE_URI + '/' + uuid + '/bmc', requested_state)
    end
  end
end
