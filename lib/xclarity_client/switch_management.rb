require 'json'

module XClarityClient
  class SwitchManagement < XClarityBase

    BASE_URI = '/switches'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      response = connection(BASE_URI)

      body = JSON.parse(response.body)
      body.map do |switch|
        Switch.new switch
      end
    end

    def get_object_switches(uuids, includeAttributes, excludeAttributes)

      response = if not includeAttributes.nil?
        get_object_switches_include_attributes(uuids, includeAttributes)
      elsif not excludeAttributes.nil?
        get_object_switches_exclude_attributes(uuids, excludeAttributes)
      elsif not uuids.nil?
        connection(BASE_URI + "/" + uuids.join(","))
      else
        connection(BASE_URI)
      end

      body = JSON.parse(response.body)
      body.map do |switch|
        Switch.new switch
      end

    end

    def get_object_switches_exclude_attributes(uuids, attributes)

      response = if not uuids.nil?
        connection(BASE_URI + "/#{uuids.join(",")}"+"?excludeAttributes=#{attributes.join(",")}")
      else
        connection(BASE_URI + "?excludeAttributes=" + attributes.join(","))
      end

    end

    def get_object_switches_include_attributes(uuids, attributes)
      response = if not uuids.nil?
        connection(BASE_URI + "/" + uuids.join(",") + "?includeAttributes=" + attributes.join(","))
      else
        connection(BASE_URI + "?includeAttributes=" + attributes.join(","))
      end
    end
  end
end
