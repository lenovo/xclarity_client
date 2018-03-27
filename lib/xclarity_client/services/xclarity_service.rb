require 'xclarity_client/connection/connection'
require 'xclarity_client/services/mixins/response_builder_mixin'
require 'xclarity_client/services/mixins/endpoint_manager_mixin'

module XClarityClient
  module Services
    class XClarityService
      include ResponseBuilderMixin
      extend  EndpointManagerMixin

      def initialize(connection_conf)
        @connection = XClarityClient::Connection.new(connection_conf)
      end

      #
      # Fetchs all resources represented by `managed_resource` from LXCA
      #
      # @return [Array] containing all `managed_resource` from LXCA
      # @see EndpointManagerMixin#managed_resource
      #
      def fetch_all(opts = {})
        $lxca_log.info "XclarityClient::Endpoints::XClarityService fetch_all",
                       "Sending request to #{managed_resource} resource"

        response = @connection.do_get(managed_resource::BASE_URI, opts)

        $lxca_log.info "XclarityClient::Endpoints::XClarityService fetch_all",
                       "Response received from #{managed_resource::BASE_URI}"

        build_response_with_resource_list(response, managed_resource)
      end

      def get_object(uuids, includeAttributes, excludeAttributes)
        $lxca_log.info "XclarityClient::Endpoints::XClarityService get_object",
                       "Sending request to #{managed_resource} resource"

        uuids.reject! { |uuid| UUID.validate(uuid).nil? } unless uuids.nil?

        response = if not includeAttributes.nil?
          get_object_with_include_attributes(uuids, includeAttributes)
        elsif not excludeAttributes.nil?
          get_object_with_exclude_attributes(uuids, excludeAttributes)
        elsif not uuids.nil?
          @connection.do_get(managed_resource::BASE_URI + "/" + uuids.join(","))
        else
          @connection.do_get(managed_resource::BASE_URI)
        end

        build_response_with_resource_list(response, managed_resource)
      end

      def get_object_with_id(ids, includeAttributes, excludeAttributes)
        response = if not includeAttributes.nil?
          get_object_with_id_include_attributes(ids, includeAttributes, managed_resource)
        elsif not excludeAttributes.nil?
          get_object_with_id_exclude_attributes(ids, excludeAttributes, managed_resource)
        elsif not ids.nil?
          @connection.do_get(managed_resource::BASE_URI + "/" + ids.join(","))
        else
          @connection.do_get(managed_resource::BASE_URI)
        end

        build_response_with_resource_list(response, managed_resource)
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
        @connection.do_get(resource::BASE_URI + filter)
        end

        build_response_with_resource_list(response, managed_resource)
      end

      private

      #
      #
      #
      def get_object_with_include_attributes(uuids, attributes)
        $lxca_log.info "XclarityClient::ManagementMixin get_object_with_include",
                       "Sending request to #{managed_resource} resource including the following attributes: #{attributes.join(",")}"

        response = if not uuids.nil?
          @connection.do_get(managed_resource::BASE_URI + "/" + uuids.join(",") + "?includeAttributes=" + attributes.join(","))
        else
          @connection.do_get(managed_resource::BASE_URI + "?includeAttributes=" + attributes.join(","))
        end

      end

      #
      #
      #
      def get_object_with_exclude_attributes(uuids, attributes)
        $lxca_log.info "XclarityClient::ManagementMixin get_object_with_include",
                       "Sending request to #{managed_resource} resource excluding the following attributes: #{attributes.join(",")}"

        response = if not uuids.nil?
          @connection.do_get(managed_resource::BASE_URI + "/#{uuids.join(",")}"+"?excludeAttributes=#{attributes.join(",")}")
        else
          @connection.do_get(managed_resource::BASE_URI + "?excludeAttributes=" + attributes.join(","))
        end
      end

      def get_object_with_id_include_attributes(uuids, attributes, resource)
        response = if not uuids.nil?
          @connection.do_get(resource::BASE_URI + "/" + uuids.join(",") + "?includeAttributes=" + attributes.join(","))
        else
          @connection.do_get(resource::BASE_URI + "?includeAttributes=" + attributes.join(","))
        end
      end

      def get_object_with_id_exclude_attributes(uuids, attributes, resource)
        response = if not uuids.nil?
          @connection.do_get(resource::BASE_URI + "/#{uuids.join(",")}"+"?excludeAttributes=#{attributes.join(",")}")
        else
          @connection.do_get(resource::BASE_URI + "?excludeAttributes=" + attributes.join(","))
        end
      end
    end
  end
end
