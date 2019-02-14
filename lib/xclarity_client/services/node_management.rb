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

    def retrieve_mounted_media_details(uuid)
      uri = Node::BASE_URI + "/#{uuid}/" + 'mediaMount'
      @connection.do_get(uri)
    end

    def enable_media_mount_support(uuid)
      uri = Node::BASE_URI + "/#{uuid}/" + 'mediaMount'
      req_body = JSON.generate(:action => 'enableMountMedia')
      @connection.do_put(uri, req_body)
    end

    def disable_media_mount_support(uuid)
      uri = Node::BASE_URI + "/#{uuid}/" + 'mediaMount'
      req_body = JSON.generate(:action => 'disableMountMedia')
      @connection.do_put(uri, req_body)
    end

    def remove_all_mounted_medias(uuid)
      uri = Node::BASE_URI + "/#{uuid}/" + 'mediaMount'
      req_body = JSON.generate(:action => 'reset')
      @connection.do_put(uri, req_body)
    end

    def mount_media(uuid, opts)
      uri = Node::BASE_URI + "/#{uuid}/" + 'mediaMount'
      req_body = JSON.generate(opts)
      @connection.do_put(uri, req_body)
    end

    def unmount_media(uuid, media_uid, media_type = '')
      uri = Node::BASE_URI + "/#{uuid}/" + 'mediaMount'
      opts = { :action => 'unmount', :UID => media_uid,
               :mediaType => media_type }
      req_body = JSON.generate(opts)
      @connection.do_put(uri, req_body)
    end
  end
end
