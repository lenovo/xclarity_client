module XClarityClient
  #
  # Exposes ManageRequestManagement features
  #
  module Mixins::ManageRequestMixin
    def fetch_manage_request(job_id)
      ManageRequestManagement.new(@config).fetch_manage_request(job_id)
    end

    def get_job_progress(dji, discovery_job_progress)
      discovery_result = DiscoverRequestManagement.new(@config)\
                                                  .monitor_discover_request(dji)
      discovery_result.map do |req|
        req.instance_variables.each do |attr|
          value = req.instance_variable_get(attr)
          discovery_job_progress = value if attr.id2name.eql?('@progress')
        end
      end
      { :discovery_job_progress => discovery_job_progress,
        :discovery_result       => discovery_result }
    end

    def get_discovery_result(discovery_job_id)
      discovery_job_id = discovery_job_id[:location].split('/')[3]
      discovery_job_progress = 0
      return false if discovery_job_id.nil?
      while discovery_job_progress < 100
        sleep 30
        opts = get_job_progress(discovery_job_id, discovery_job_progress)
        discovery_job_progress = opts[:discovery_job_progress]
      end
      opts[:discovery_result]
    end

    def update_manage_request(manage_request, force, discovery_result)
      ManageRequestManagement.new(@config)\
                             .update_manage_request(manage_request,
                                                    force,
                                                    discovery_result)
    end

    def manage_discovered_devices(manage_request, force)
      discovery_job_id = DiscoverRequestManagement.new(@config)\
                                                  .discover_manageable_devices(
                                                    manage_request[:ip_address]
                                                  )
      d_res = get_discovery_result(discovery_job_id)
      raise 'manageable device Discovery failed' unless d_res
      update_manage_request(manage_request, force, d_res)
      ManageRequestManagement.new(@config)\
                             .manage_discovered_devices(manage_request)
    end
  end
end
