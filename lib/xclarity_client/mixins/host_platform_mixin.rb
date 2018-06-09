module XClarityClient
  #
  # Exposes HostPlatformManagement features
  #
  module Mixins::HostPlatformMixin
    def get_hostplatforms
      HostPlatformManagement.new(@config).fetch_all
    end

    def get_osimage_deployment_status(uuid = '')
      HostPlatformManagement.new(@config).get_osimage_deployment_status(uuid)
    end

    def deploy_osimage(opts = [])
      HostPlatformManagement.new(@config).deploy_osimage(opts)
    end
  end
end
