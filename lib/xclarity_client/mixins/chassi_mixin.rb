module XClarityClient
  #
  # Exposes ChassiManagement features
  #
  module Mixins::ChassiMixin
    def discover_chassis(opts = {})
      chassi_management.fetch_all(opts)
    end

    def fetch_chassis(uuids = nil,
                      include_attributes = nil,
                      exclude_attributes = nil)
      chassi_management.get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end

    def blink_loc_led_chassis(uuid = '', name = 'Location')
      chassi_management.set_loc_led_state(uuid, 'Blinking', name)
    end

    def turn_on_loc_led_chassis(uuid = '', name = 'Location')
      chassi_management.set_loc_led_state(uuid, 'On', name)
    end

    def turn_off_loc_led_chassis(uuid = '', name = 'Location')
      chassi_management.set_loc_led_state(uuid, 'Off', name)
    end

    private

    def chassi_management
      ChassiManagement.new(@config)
    end
  end
end
