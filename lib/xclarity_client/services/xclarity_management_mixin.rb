module XClarityClient
  module ManagementMixin
    def get_all_resources (resource, opts = {})
      $lxca_log.info "XclarityClient::ManagementMixin get_all_resources", "Sending request to #{resource} resource"

      response = connection(resource::BASE_URI, opts)

      $lxca_log.info "XclarityClient::ManagementMixin get_all_resources", "Response received from #{resource::BASE_URI}"

      return [] unless response.success?

      body = JSON.parse(response.body)
      if resource == XClarityClient::User
        body = body['response']
      end

      list_name, body = add_listname_on_body(resource, body)

      body[list_name].map do |resource_params|
        resource.new resource_params
      end
    end

    def get_object(uuids, includeAttributes, excludeAttributes, resource)

      $lxca_log.info "XclarityClient::ManagementMixin get_object", "Sending request to #{resource} resource"

      uuids.reject! { |uuid| UUID.validate(uuid).nil? } unless uuids.nil?

      response = if not includeAttributes.nil?
        get_object_with_include_attributes(uuids, includeAttributes, resource)
      elsif not excludeAttributes.nil?
        get_object_with_exclude_attributes(uuids, excludeAttributes, resource)
      elsif not uuids.nil?
        connection(resource::BASE_URI + "/" + uuids.join(","))
      else
        connection(resource::BASE_URI)
      end

      return [] unless response.success?

      body = JSON.parse(response.body)
      body = {resource::LIST_NAME => body} if body.is_a? Array
      body = {resource::LIST_NAME => [body]} unless body.has_key? resource::LIST_NAME
      body[resource::LIST_NAME].map do |resource_params|
        resource.new resource_params
      end
    end

    def get_object_with_include_attributes(uuids, attributes, resource)

      $lxca_log.info "XclarityClient::ManagementMixin get_object_with_include", "Sending request to #{resource} resource including the following attributes: #{attributes.join(",")}"

      uuids.reject! { |uuid| UUID.validate(uuid).nil? } unless uuids.nil?

      response = if not uuids.nil?
        connection(resource::BASE_URI + "/" + uuids.join(",") + "?includeAttributes=" + attributes.join(","))
      else
        connection(resource::BASE_URI + "?includeAttributes=" + attributes.join(","))
      end

    end

    def get_object_with_exclude_attributes(uuids, attributes, resource)

      $lxca_log.info "XclarityClient::ManagementMixin get_object_with_include", "Sending request to #{resource} resource excluding the following attributes: #{attributes.join(",")}"

      uuids.reject! { |uuid| UUID.validate(uuid).nil? } unless uuids.nil?

      response = if not uuids.nil?
        connection(resource::BASE_URI + "/#{uuids.join(",")}"+"?excludeAttributes=#{attributes.join(",")}")
      else
        connection(resource::BASE_URI + "?excludeAttributes=" + attributes.join(","))
      end
    end

    def get_object_with_id(ids, includeAttributes, excludeAttributes, resource)
      response = if not includeAttributes.nil?
        get_object_with_id_include_attributes(ids, includeAttributes, resource)
      elsif not excludeAttributes.nil?
        get_object_with_id_exclude_attributes(ids, excludeAttributes, resource)
      elsif not ids.nil?
        connection(resource::BASE_URI + "/" + ids.join(","))
      else
        connection(resource::BASE_URI)
      end

      return [] unless response.success?

      body = JSON.parse(response.body)

      if resource == XClarityClient::User
        body = body['response']
      end

      body = {resource::LIST_NAME => body} if body.is_a? Array
      body = {resource::LIST_NAME => [body]} unless body.has_key? resource::LIST_NAME
      body[resource::LIST_NAME].map do |resource_params|
        resource.new resource_params
      end
    end

    def get_object_with_id_include_attributes(uuids, attributes, resource)
      response = if not uuids.nil?
        connection(resource::BASE_URI + "/" + uuids.join(",") + "?includeAttributes=" + attributes.join(","))
      else
        connection(resource::BASE_URI + "?includeAttributes=" + attributes.join(","))
      end
    end

    def get_object_with_id_exclude_attributes(uuids, attributes, resource)
      response = if not uuids.nil?
        connection(resource::BASE_URI + "/#{uuids.join(",")}"+"?excludeAttributes=#{attributes.join(",")}")
      else
        connection(resource::BASE_URI + "?excludeAttributes=" + attributes.join(","))
      end
    end

    def get_object_with_opts(opts, resource)
      raise "The opts cannot be empty" if opts.empty?
      filter = ""

      response = if not opts.empty?
        if not opts.has_key? "type"
          if opts.has_key? "filterWith"
            filter += "?filterWith="
            filter += "#{opts["filterWith"]}"

          elsif opts.has_key? "sort"
            filter += ",sort=" if filter != ""
            filter += "?sort=" if filter == ""
            filter += "#{opts["sort"]}"
          end
        else
          filter += "?type=#{opts["type"]}"
        end
      $lxca_log.info "XclarityClient::ManagementMixin get_object_with_include", "Sending request to #{resource} resource using the following filter: #{filter}"
      connection(resource::BASE_URI + filter)
      end

      return [] unless response.success?

      body = JSON.parse(response.body)
      body = {resource::LIST_NAME => body} if body.is_a? Array
      body = {resource::LIST_NAME => [body]} unless body.has_key? resource::LIST_NAME
      body[resource::LIST_NAME].map do |resource_params|
        resource.new resource_params
      end
    end

    private

    # Process the response body to make sure that its contains the list name defined on resource
    # Returns the list name present on body and the body itself
    def add_listname_on_body(resource, body)
      body.kind_of?(Array) ? process_body_as_array(resource, body) : process_body_as_hash(resource, body)
    end

    # Return any listname described on resource
    def any_listname_of(resource)
      if resource::LIST_NAME.kind_of?(Array)
        resource::LIST_NAME.first # If is an array, any listname can be use
      else
        resource::LIST_NAME # If is not an array, just return the listname of resource
      end
    end

    # Returns the body value assigned to the list name defined on resource
    def process_body_as_array(resource, body)
      list_name = any_listname_of(resource)

      return list_name, { list_name => body } # assign the list name to the body
    end

    # Discover what list name defined on resource is present on body
    # If none of then is find assume that the body is a single resource
    # and add it value into array and assing to any list name
    def process_body_as_hash(resource, body)
      result = body

      if resource::LIST_NAME.kind_of? Array # search which list name is present on body
        list_name = resource::LIST_NAME.find { |name| body.keys.include?(name) && body[name].kind_of?(Array) }
      else
        list_name = any_listname_of(resource)
      end
      result = {list_name => [body]} unless body.has_key? list_name # for the cases where body represents a single resource
      return list_name, result
    end
  end
end
