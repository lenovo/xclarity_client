require 'json'

module XClarityClient
  class JobManagement < Services::XClarityService
    manages_endpoint Job

    def population(opts = {})
      fetch_all(opts)
    end

    def cancel_job(uuid='')
      cancelReq = JSON.generate(cancelRequest: 'true')
      response = @connection.do_put(managed_resource::BASE_URI + '/' + uuid, cancelReq)
      response
    end

    def delete_job(uuid='')
      response = @connection.do_delete(managed_resource::BASE_URI + '/' + uuid)
      response
    end

    def get_job(job_id = "")
      response = connection(Job::BASE_URI + '/' + job_id)
      response = JSON.parse(response.body)
    end
  end
end
