module XClarityClient
  #
  # Exposes DiscoverRequestManagement features
  #
  module Mixins::DiscoverRequestMixin
    def monitor_discover_request(job_id)
      DiscoverRequestManagement.new(@config).monitor_discover_request(
        job_id
      )
    end

    def discover_manageable_devices(ip_addresses)
      DiscoverRequestManagement.new(@config).discover_manageable_devices(
        ip_addresses
      )
    end
  end
end
