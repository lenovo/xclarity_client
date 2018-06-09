require 'json'

module XClarityClient
  class DiscoverRequestManagement < Services::XClarityService
    manages_endpoint DiscoverRequest

    def discover_manageable_devices(ip_addresses)
      post_req = JSON.generate([ipAddresses: ip_addresses])
      response = @connection.do_post(managed_resource::BASE_URI, post_req)
      response
    end

    def monitor_discover_request(job_id)
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
