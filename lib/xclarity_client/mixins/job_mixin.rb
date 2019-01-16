module XClarityClient
  #
  # Exposes JobManagement features
  #
  module Mixins::JobMixin
    def discover_jobs(opts = {})
      JobManagement.new(@config).fetch_all(opts)
    end

    def fetch_jobs(ids = nil,
                   include_attributes = nil,
                   exclude_attributes = nil)
      JobManagement.new(@config).get_object_with_id(
        ids,
        include_attributes,
        exclude_attributes
      )
    end

    def cancel_job(id = '')
      JobManagement.new(@config).cancel_job(id)
    end

    def delete_job(id = '')
      JobManagement.new(@config).delete_job(id)
    end
  end
end
