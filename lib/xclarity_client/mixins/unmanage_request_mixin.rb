module XClarityClient
  #
  # Exposes UnmanageRequestManagement features
  #
  module Mixins::UnmanageRequestMixin
    def fetch_unmanage_request(job_id)
      UnmanageRequestManagement.new(@config).fetch_unmanage_request(
        job_id
      )
    end

    def unmanage_discovered_devices(endpoints, force)
      UnmanageRequestManagement.new(@config).unmanage_discovered_devices(
        endpoints, force
      )
    end
  end
end
