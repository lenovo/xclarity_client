module XClarityClient
  module ManagementMixin


    def get_all_resources (resource)
      response = connection(resource::BASE_URI)

      return [] unless response.success?

      body = JSON.parse(response.body)
      body = {resource::LIST_NAME => body} if body.is_a? Array
      body = {resource::LIST_NAME => [body]} unless body.has_key? resource::LIST_NAME
      body[resource::LIST_NAME].map do |resource_params|
        resource.new resource_params
      end
    end

    def get_object(uuids, includeAttributes, excludeAttributes, resource)

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

      uuids.reject! { |uuid| UUID.validate(uuid).nil? } unless uuids.nil?

      response = if not uuids.nil?
        connection(resource::BASE_URI + "/" + uuids.join(",") + "?includeAttributes=" + attributes.join(","))
      else
        connection(resource::BASE_URI + "?includeAttributes=" + attributes.join(","))
      end

    end

    def get_object_with_exclude_attributes(uuids, attributes, resource)

      uuids.reject! { |uuid| UUID.validate(uuid).nil? } unless uuids.nil?

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
          end
          if opts.has_key? "sort"
            filter += ",sort=" if filter != ""
            filter += "?sort=" if filter == ""
            filter += "#{opts["sort"]}"
          end
        else
          filter += "?type=#{opts["type"]}"
        end
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

  end
end
