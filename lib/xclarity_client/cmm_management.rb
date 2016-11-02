require 'json'

module XClarityClient
  class CmmManagement < XClarityBase

    BASE_URI = '/cmms'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      response = connection(BASE_URI)

      body = JSON.parse(response.body)
      body = {'cmmList' => [body]} unless body.has_key? 'cmmList'
      body['cmmList'].map do |cmm|
        Cmm.new cmm
      end
    end

    def get_object_cmms(uuids, includeAttributes, excludeAttributes)

      if not includeAttributes.nil?
        response = get_object_cmms_include_attributes(uuids, includeAttributes)
      elsif not excludeAttributes.nil?
        response = get_object_cmms_exclude_attributes(uuids, excludeAttributes)
      elsif not uuids.nil?
        response = connection(BASE_URI + "/" + uuids.join(","))
      else
        response = connection(BASE_URI)
      end


        body = JSON.parse(response.body) #rescue {}
        body = {'cmmList' => [body]} unless body.has_key? 'cmmList'
        body['cmmList'].map do |cmm|
          Cmm.new cmm
        end
    end

    private

    def get_object_cmms_exclude_attributes(uuids, attributes)
      if not uuids.nil?
        response = connection(BASE_URI + "/#{uuids.join(",")}"+"?excludeAttributes=#{attributes.join(",")}")
      else
        response = connection(BASE_URI + "?excludeAttributes=" + attributes.join(","))
      end
    end

    def get_object_cmms_include_attributes(uuids, attributes)
      if not uuids.nil?
        response = connection(BASE_URI + "/" + uuids.join(",") + "?includeAttributes=" + attributes.join(","))
      else
        response = connection(BASE_URI + "?includeAttributes=" + attributes.join(","))
      end
    end

  end
end
