require 'json'

module XClarityClient
  class ConfigpatternManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, Configpattern::BASE_URI)
    end

    def population()
      get_all_resources(Configpattern)
    end

    def export(id)
      response = connection(Configpattern::BASE_URI + "/" + id + "/includeSettings" )      
      return [] unless response.success?

      body = JSON.parse(response.body)

      body = {Configpattern::LIST_NAME => body} if body.is_a? Array
      body = {Configpattern::LIST_NAME => [body]} unless body.has_key? Configpattern::LIST_NAME
      body[Configpattern::LIST_NAME].map do |resource_params|
        Configpattern.new resource_params
      end
    end

    def deploy_configpattern(id,endpoints,restart,etype)
      if etype.eql? 'node'
        deployHash = {:uuid => endpoints}
      elsif etype.eql? 'rack' or etype.eql? 'tower'
        deployHash = {:endpointIds => endpoints}
      end
      deployHash.merge!({:restart => restart})
      puts deployHash
      puts JSON.generate(deployHash)
      response = do_post(Configpattern::BASE_URI + '/' +id, JSON.generate(deployHash))
      puts response.body

    end

    def import_configpattern(configpattern)
      response = do_post(Configpattern::BASE_URI, configpattern)
      puts response.body
    end

  end
end

