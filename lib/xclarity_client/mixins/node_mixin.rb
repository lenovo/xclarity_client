module XClarityClient
  #
  # Exposes NodeManagement features
  #
  module Mixins::NodeMixin
    def discover_nodes(opts = {})
      node_management.fetch_all(opts)
    end

    def fetch_nodes(uuids = nil,
                    include_attributes = nil,
                    exclude_attributes = nil)
      node_management.get_object(
        uuids,
        include_attributes,
        exclude_attributes
      )
    end

    def blink_loc_led(uuid = '', name = 'Identify')
      node_management.set_loc_led_state(uuid, 'Blinking', name)
    end

    def turn_on_loc_led(uuid = '', name = 'Identify')
      node_management.set_loc_led_state(uuid, 'On', name)
    end

    def turn_off_loc_led(uuid = '', name = 'Identify')
      node_management.set_loc_led_state(uuid, 'Off', name)
    end

    def power_on_node(uuid = '')
      node_management.set_power_state(uuid, :powerOn)
    end

    def power_off_node(uuid = '')
      node_management.set_power_state(uuid, :powerOffSoftGraceful)
    end

    def power_off_node_now(uuid = '')
      node_management.set_power_state(uuid, :powerOff)
    end

    def power_restart_node(uuid = '')
      node_management.set_power_state(uuid, :powerCycleSoftGrace)
    end

    def power_restart_node_now(uuid = '')
      node_management.set_power_state(uuid, :powerCycleSoft)
    end

    def power_restart_node_controller(uuid = '')
      node_management.set_bmc_power_state(uuid, :restart)
    end

    def power_restart_node_to_setup(uuid = '')
      node_management.set_power_state(uuid, :bootToF1)
    end

    def retrieve_mounted_media_details(uuid = '')
      node_management.retrieve_mounted_media_details(uuid)
    end

    def enable_media_mount_support_thinkserver(uuid = '')
      node_management.enable_media_mount_support(uuid)
    end

    def disable_media_mount_support_thinkserver(uuid = '')
      node_management.disable_media_mount_support(uuid)
    end

    def remove_all_mounted_medias_thinksystem(uuid = '')
      node_management.remove_all_mounted_medias(uuid)
    end

    def mount_media_thinkserver(uuid, opts)
      validate_mount_media_params(opts)
      node_management.mount_media(uuid, opts)
    end

    def mount_media_thinksystem(uuid, opts)
      validate_mount_media_params(opts, 'thinksystem')
      node_management.mount_media(uuid, opts)
    end

    def unmount_media_thinkserver(uuid, media_uid)
      node_management.unmount_media(uuid, media_uid)
    end

    def unmount_media_thinksystem(uuid, media_uid, media_type)
      node_management.unmount_media(uuid, media_uid, media_type)
    end

    private

    def validate_mount_media_params(opts, server_type = '')
      msg = 'parameter opts should be of type hash, below are valid fields '\
            + "of hash \n\n"
      msg_params =  ":mediaLocation      => Full path of media iso\n"\
                  + ":mediaServerAddress => Ip Address of the server on\n"\
                  + "                        which media is located\n"\
                  + ":mediaType => (for ThinkServersOnly) The media type\n"\
                  + "               this can be one of following\n"\
                  + "  1) CD/DVD - CD drive\n"\
                  + "  2) FD - flash drive\n  3) HD - disk drive\n"\
                  + ":shareType => share type can be one of following \n"\
                  + "  1) ftp\n  2) http\n  3) sftp\n  4) https\n"\
                  + "  5) nfs\n  6) samba\n"\
                  + ":username  => Required if shareType is samba,\n"\
                  + "              User name to authenticate media\n"\
                  + ":password  => Required if shareType is samba,\n"\
                  + '              password to authenticate media'
      err_msg = msg + msg_params
      raise(err_msg) unless opts.kind_of?(Hash)

      err_msg = ':mediaType is mandatory field in input hash for thinksystem'
      raise(err_msg) if server_type == 'thinksystem' &&
                        !opts.keys.include?(:mediaType)
    end

    def node_management
      NodeManagement.new(@config)
    end
  end
end
