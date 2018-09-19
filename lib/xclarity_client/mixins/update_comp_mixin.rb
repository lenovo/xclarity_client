module XClarityClient
  #
  # Exposes UpdateCompManagement features
  #
  module Mixins::UpdateCompMixin
    def discover_firmware_update_status
      UpdateCompManagement.new(@config).fetch_all
    end

    def discover_updatable_device_comp
      UpdateCompManagement.new(@config).updatable_device_comp
    end

    def apply_firmware_update(opts, activation_mode = nil,
                              force_update_mode = nil, onerror_mode = nil)
      UpdateCompManagement.new(@config).apply_firmware_update(opts,
                                                              activation_mode,
                                                              force_update_mode,
                                                              onerror_mode)
    end

    def cancel_firmware_update(server = nil, switch = nil, storage = nil,
                               cmm = nil)
      UpdateCompManagement.new(@config).cancel_firmware_update(server,
                                                               switch,
                                                               storage,
                                                               cmm)
    end

    def modify_power_state(server = nil, switch = nil, storage = nil, cmm = nil)
      UpdateCompManagement.new(@config).modify_power_state(server,
                                                           switch,
                                                           storage,
                                                           cmm)
    end
  end
end
