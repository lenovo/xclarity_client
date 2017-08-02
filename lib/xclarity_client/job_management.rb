require 'json'

module XClarityClient
  class JobManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Job::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(Job, opts)
    end

    def cancel_job(uuid='')
      cancelReq = JSON.generate(cancelRequest: 'true')
      response = do_put(Job::BASE_URI + '/' + uuid, cancelReq)
      puts response.body
    end

    def delete_job(uuid='')
      response = do_delete(Job::BASE_URI + '/' + uuid)
      puts response.body
    end

  end
end
