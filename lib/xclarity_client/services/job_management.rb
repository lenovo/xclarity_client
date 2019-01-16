require 'json'

module XClarityClient
  class JobManagement < Services::XClarityService
    manages_endpoint Job

    def cancel_job(uuid='')
      cancelReq = JSON.generate(cancelRequest: 'true')
      @connection.do_put(managed_resource::BASE_URI + '/' + uuid, cancelReq)
    end

    def delete_job(uuid='')
      @connection.do_delete(managed_resource::BASE_URI + '/' + uuid)
    end
  end
end
