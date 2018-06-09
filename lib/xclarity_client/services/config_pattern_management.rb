require 'json'

module XClarityClient
  class ConfigPatternManagement < Services::XClarityService
    manages_endpoint ConfigPattern

    def export(id)
      response = @connection.do_get(managed_resource::BASE_URI + "/" + id + "/includeSettings" )
      return [] unless response.success?

      body = JSON.parse(response.body)

      body = {managed_resource::LIST_NAME => body} if body.is_a? Array
      body = {managed_resource::LIST_NAME => [body]} unless body.has_key? managed_resource::LIST_NAME
      body[managed_resource::LIST_NAME].map do |resource_params|
        managed_resource.new resource_params
      end
    end

    def deploy_config_pattern(id,endpoints,restart,etype)
      if etype.eql? 'node'
        deployHash = {:uuid => endpoints}
      elsif etype.eql? 'rack' or etype.eql? 'tower'
        deployHash = {:endpointIds => endpoints}
      end
      deployHash.merge!({:restart => restart})
      response = @connection.do_post(managed_resource::BASE_URI + '/' +id, JSON.generate(deployHash))
      response

    end

    def import_config_pattern(config_pattern)
      response = @connection.do_post(managed_resource::BASE_URI, config_pattern)
      response
    end
  end
end
