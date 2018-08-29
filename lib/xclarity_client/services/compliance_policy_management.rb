require 'json'

module XClarityClient
  class CompliancePolicyManagement < Services::XClarityService
    manages_endpoint CompliancePolicy

    def get_applicable_firmware
      get_update_policy(managed_resource::SUB_URIS[:applicableFirmware], {})
    end

    def get_persisted_compare_results(opts = {})
      get_update_policy(managed_resource::SUB_URIS[:persistedResult], opts)
    end
    
    def get_compare_results(opts = {})
      get_update_policy(managed_resource::SUB_URIS[:compareResult], opts)
    end
    
    def get_update_policy(uri, opts = {})
      fetch_all(opts, uri)
    end

    def assign_compliance_policy(opts = {}, keep, auto_assign)
      assign_hash = {:policyname => opts["policyname"], :type => opts["type"], :uuid => opts["uuid"]}
      
      #Append keep only if value is false since default is true.
      if keep.eql? "False" or keep.eql? "false"
        assign_hash.merge!({:keep => false})
      end
      
      #Append auto_assign only is value is true since default is false  
      if auto_assign.eql? "True" or auto_assign.eql? "true"
        assign_hash.merge!({:autoAssign => true})
      end

      assign_hash_str = assign_hash.to_json
      response = @connection.do_post(managed_resource::SUB_URIS[:compareResult], "{\"compliance\": [#{assign_hash_str}]}") 
      response.body
    end

    def delete_compliance_policy(policy_name,removePackage)
      query = policy_name.nil? ? "" : "?policyName=" + policy_name
      query = removePackage.nil? ? query : query + "&removePackage=" + removePackage 
      response = @connection.do_delete(managed_resource::BASE_URI + query)
      response.body
    end

  end
end

