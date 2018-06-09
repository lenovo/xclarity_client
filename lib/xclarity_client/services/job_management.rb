require 'json'

module XClarityClient
  class JobManagement < Services::XClarityService
    manages_endpoint Job

    def cancel_job(uuid='')
      cancelReq = JSON.generate(cancelRequest: 'true')
      response = @connection.do_put(managed_resource::BASE_URI + '/' + uuid, cancelReq)
      response
    end

    def delete_job(uuid='')
      response = @connection.do_delete(managed_resource::BASE_URI + '/' + uuid)
      response
    end
  end
end
