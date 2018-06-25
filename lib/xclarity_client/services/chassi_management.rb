require 'xclarity_client/services/mixins/power_action_sender_mixin'

module XClarityClient
  class ChassiManagement < Services::XClarityService
    include Services::PowerActionSenderMixin

    manages_endpoint Chassi
  end
end
