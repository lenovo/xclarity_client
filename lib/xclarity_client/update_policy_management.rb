require 'json'

module XClarityClient
  class UpdatePolicyManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, UpdatePolicy::BASE_URI)
    end

    def population(opts = {})
      get_all_resources(UpdatePolicy, opts)
    end

    def get_applicable_firmware()
      get_update_policy("applicableFirmware", {})
    end

    def get_persisted_compare_results(opts = {})
      get_update_policy("persistedResult", opts)
    end
    
    def get_compare_results(opts = {})
      get_update_policy("compareResult", opts)
    end
    
    def get_update_policy(uri, opts = {})
      query = opts.size > 0 ? "?" + opts.map {|k, v| "#{k}=#{v}"}.join("&") : ""      
      response = connection(UpdatePolicy::BASE_URI + "/" + uri + query)
      return [] unless response.success?

      body = JSON.parse(response.body)

      body = {UpdatePolicy::LIST_NAME => body} if body.is_a? Array
      body = {UpdatePolicy::LIST_NAME => [body]} unless body.has_key? UpdatePolicy::LIST_NAME
      body[UpdatePolicy::LIST_NAME].map do |resource_params|
        UpdatePolicy.new resource_params
      end
    end

    def assign_compliance_policy(policy_name, type, uuid, keep, auto_assign)
      assign_hash = {:policyname => policy_name, :type => type, :uuid => uuid}
      
      #Append keep only if value is false since default is true.
      if !keep.nil? and (keep.eql? "False" or keep.eql? "false")
        assign_hash.merge!({:keep => false})
      end
      
      #Append auto_assign only is value is true since default is false  
      if !auto_assign.nil? and (auto_assign.eql? "True" or auto_assign.eql? "true")
        assign_hash.merge!({:autoAssign => true})
      end

      assign_hash_str = assign_hash.to_json
      response = do_post(UpdatePolicy::BASE_URI + "/compareResult", "{\"compliance\": [#{assign_hash_str}]}") 
      puts response.body
    end

    def delete_compliance_policy(policy_name,removePackage)
      query = policy_name.nil? ? "" : "?policyName=" + policy_name
      query = removePackage.nil? ? query : query + "&removePackage=" + removePackage 
      response = do_delete(UpdatePolicy::BASE_URI + query)
      puts response.body
    end

  end
end
