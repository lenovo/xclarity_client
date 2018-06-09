module XClarityClient
  #
  # Exposes SwitchManagement features
  #
  module Mixins::SwitchMixin
    def discover_switches(opts = {})
      switch_management.fetch_all(opts)
    end

    def fetch_switches(uuids = nil,
                       include_attributes = nil,
                       exclude_attributes = nil)
      switch_management.get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end

    def power_cycle_soft_switch(uuid = '')
      switch_management.set_power_state(uuid, :powerCycleSoft)
    end

    private

    def switch_management
      SwitchManagement.new(@config)
    end
  end
end
