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
      body.map do |cmm|
        Cmm.new cmm
      end
    end

    def get_object_cmms(uuids, includeAttributes, excludeAttributes)

      if not includeAttributes.nil?
        get_object_cmms_include_attributes(uuids, includeAttributes)
      elsif not excludeAttributes.nil?
        get_object_cmms_exclude_attributes(uuids, excludeAttributes)
      elsif not uuids.nil?
        response = connection(BASE_URI + "/" + uuids)
        body = JSON.parse(response.body)
        Cmm.new body
      else
        response = connection(BASE_URI)
        body = JSON.parse(response.body)
        body.map do |cmm|
          Cmm.new cmm
        end
      end

    end

    private

    def get_object_cmms_exclude_attributes(uuids, attributes)
      if not uuids.nil?
        response = connection(BASE_URI + "/"+uuids +"?excludeAttributes="+ attributes.join(","))
        body = JSON.parse(response.body)
        Cmm.new body
      else
        response = connection(BASE_URI + "?excludeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        body.map do |cmm|
          Cmm.new cmm
        end
      end
    end

    def get_object_cmms_include_attributes(uuids, attributes)
      if not uuids.nil?
        response = connection(BASE_URI + "/" + uuids + "?includeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        Cmm.new body
      else
        response = connection(BASE_URI + "?includeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        body.map do |cmm|
          Cmm.new cmm
        end
      end
    end

  end
end
