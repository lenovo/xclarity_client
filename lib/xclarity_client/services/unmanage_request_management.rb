require 'json'

module XClarityClient
  class UnmanageRequestManagement< Services::XClarityService
    manages_endpoint UnmanageRequest

    def unmanage_discovered_devices(endpoints, force)
      deploy_hash = {}
      deploy_hash.merge!({:endpoints => endpoints})
      if force.downcase.eql? "true"
        deploy_hash.merge!({:forceUnmanage => true})
      else
         deploy_hash.merge!({:forceUnmanage => false})
        end
        response = @connection.do_post(managed_resource::BASE_URI, JSON.generate(deploy_hash))
      if response.status == 200 or response.status == 201
        puts response.headers[:location].split("/")[-1]
      end
    end

    def fetch_unmanage_request(job_id)
      response = @connection.do_get(managed_resource::BASE_URI + "/jobs/" + job_id)
      return [] unless response.success?

      body = JSON.parse(response.body)

      body = {managed_resource::LIST_NAME => body} if body.is_a? Array
      body = {managed_resource::LIST_NAME => [body]} unless body.has_key? managed_resource::LIST_NAME
      body[managed_resource::LIST_NAME].map do |resource_params|
        managed_resource.new resource_params
      end
    end
  end
end
