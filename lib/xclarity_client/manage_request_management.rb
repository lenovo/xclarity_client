require 'json'

module XClarityClient
  class ManageRequestManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      @conf = conf
      super(conf, ManageRequest::BASE_URI)
    end

    def manage_discovered_devices(ip_address, username, password, recovery_password, force)
      discovery_job_id = DiscoverRequestManagement.new(@conf).discover_manageable_devices(ip_address)[:location].split("/")[3]

      discovery_job_progress = 0

      if !discovery_job_id.nil?
        while discovery_job_progress < 100 do
          sleep 30
          discover_result = DiscoverRequestManagement.new(@conf).monitor_discover_request(discovery_job_id)

          discover_result.map do |req|
            req.instance_variables.each do |attr|
              if attr.id2name.eql? "@progress"
                discovery_job_progress = req.instance_variable_get attr
             end
            end
          end
        end
      end   

      deploy_hash = create_deploy_hash(ip_address, username, password, recovery_password, force, discover_result)
      puts JSON.generate([deploy_hash])
      response = do_post(ManageRequest::BASE_URI, JSON.generate([deploy_hash]))
      if response.status == 200 or response.status == 201
        puts response.headers[:location].split("/")[-1]
      end

    end

    def create_deploy_hash(ip_address, username, password, recovery_password, force, discover_result)
      deploy_hash = {:ipAddresses => ip_address, :username => username, :password => password, :recoveryPassword => recovery_password} 
      discover_result.map do |req|
        req.instance_variables.each do |attr|
          val = req.instance_variable_get attr
          if val.instance_of? Array and !val.empty?
            deploy_hash.merge!({:managementPorts => val[0]["managementPorts"], :type => val[0]["type"], :uuid => val[0]["uuid"]})
            discovery_ip_addr = val[0]["ipAddresses"][0]
            deploy_hash.merge!({:ipAddresses => [discovery_ip_addr]})

            if val[0]["type"].eql? "Rackswitch"
              deploy_hash.merge!({:os => val[0]["os"]})
            end
          end
        end
      end
      if force.downcase.eql? "true"
        deploy_hash.merge!({:forceManage => true})
      end
      security_descriptor = {}
      security_descriptor["managedAuthEnabled"] = true
      security_descriptor["managedAuthSupported"] = false
      deploy_hash.merge!({:securityDescriptor => security_descriptor}) 
      deploy_hash
    end

    def fetch_manage_request(job_id)
      response = connection(ManageRequest::BASE_URI + "/jobs/" + job_id)
      return [] unless response.success?

      body = JSON.parse(response.body)

      body = {ManageRequest::LIST_NAME => body} if body.is_a? Array
      body = {ManageRequest::LIST_NAME => [body]} unless body.has_key? ManageRequest::LIST_NAME
      body[ManageRequest::LIST_NAME].map do |resource_params|
        ManageRequest.new resource_params
      end
    end

  end
end
