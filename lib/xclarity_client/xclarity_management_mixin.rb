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

    # Discover which list name is present on the response body.
    # Util for cases that list name was changed on different api versions
    # in this cases need to provide a list of list names
    def add_listname_on_body(resource, body)
      list_name = resource::LIST_NAME.kind_of?(Array) ? resource::LIST_NAME.first : resource::LIST_NAME
      return list_name, { list_name => body } if body.kind_of? Array

      result = body # body is a Hash
      if resource::LIST_NAME.kind_of? Array # need to search which list name is present on body
        list_name = resource::LIST_NAME.find { |name| body.keys.include?(name) && body[name].kind_of?(Array) }
      end
      result = {list_name => [body]} unless body.has_key? list_name
      return list_name, result
    end
  end
end
