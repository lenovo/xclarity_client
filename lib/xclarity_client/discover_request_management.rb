require 'json'

module XClarityClient
  class DiscoverRequestManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, DiscoverRequest::BASE_URI)
    end

    def discover_manageable_devices(ip_addresses)
      postReq = JSON.generate(["ipAddresses":ip_addresses])
      response = do_post(DiscoverRequest::BASE_URI, postReq)
      response
    end

    def monitor_discover_request(job_id)
      response = connection(DiscoverRequest::BASE_URI + "/jobs/" + job_id)
      return [] unless response.success?

      body = JSON.parse(response.body)

      body = {DiscoverRequest::LIST_NAME => body} if body.is_a? Array
      body = {DiscoverRequest::LIST_NAME => [body]} unless body.has_key? DiscoverRequest::LIST_NAME
      body[DiscoverRequest::LIST_NAME].map do |resource_params|
        DiscoverRequest.new resource_params
      end
    end

  end
end
