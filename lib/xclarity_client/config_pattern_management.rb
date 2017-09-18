require 'json'

module XClarityClient
  class ConfigPatternManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, ConfigPattern::BASE_URI)
    end

    def population()
      get_all_resources(ConfigPattern)
    end

    def export(id)
      response = connection(ConfigPattern::BASE_URI + "/" + id + "/includeSettings" )      
      return [] unless response.success?

      body = JSON.parse(response.body)

      body = {ConfigPattern::LIST_NAME => body} if body.is_a? Array
      body = {ConfigPattern::LIST_NAME => [body]} unless body.has_key? ConfigPattern::LIST_NAME
      body[ConfigPattern::LIST_NAME].map do |resource_params|
        ConfigPattern.new resource_params
      end
    end

    def deploy_config_pattern(id,endpoints,restart,etype)
      if etype.eql? 'node'
        deployHash = {:uuid => endpoints}
      elsif etype.eql? 'rack' or etype.eql? 'tower'
        deployHash = {:endpointIds => endpoints}
      end
      deployHash.merge!({:restart => restart})
      puts deployHash
      puts JSON.generate(deployHash)
      response = do_post(ConfigPattern::BASE_URI + '/' +id, JSON.generate(deployHash))
      puts response.body

    end

    def import_config_pattern(config_pattern)
      response = do_post(ConfigPattern::BASE_URI, config_pattern)
      puts response.body
    end

  end
end

