require 'xclarity_client/services/mixins/power_action_sender_mixin'

module XClarityClient
  class SwitchManagement< Services::XClarityService
    include Services::PowerActionSenderMixin

    manages_endpoint Switch
  end
end
