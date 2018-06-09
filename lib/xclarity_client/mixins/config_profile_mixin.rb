module XClarityClient
  #
  # Exposes ConfigProfileManagement features
  #
  module Mixins::ConfigProfileMixin
    def fetch_config_profile(ids = nil,
                             include_attributes = nil,
                             exclude_attributes = nil)
      ConfigProfileManagement.new(@config).get_object_with_id(
        ids,
        include_attributes,
        exclude_attributes
      )
    end

    def discover_config_profile
      ConfigProfileManagement.new(@config).fetch_all
    end

    def rename_config_profile(id = '', name = '')
      ConfigProfileManagement.new(@config).rename_config_profile(
        id,
        name
      )
    end

    def activate_config_profile(id = '', endpoint_uuid = '', restart = '')
      ConfigProfileManagement.new(@config).activate_config_profile(
        id,
        endpoint_uuid,
        restart
      )
    end

    def unassign_config_profile(id = '',
                                power_down = '',
                                reset_imm = '',
                                force = '')
      ConfigProfileManagement.new(@config).unassign_config_profile(
        id,
        power_down,
        reset_imm,
        force
      )
    end

    def delete_config_profile(id = '')
      ConfigProfileManagement.new(@config).delete_config_profile(id)
    end
  end
end
