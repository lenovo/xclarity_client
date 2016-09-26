require 'json'

module XClarityClient
  class ChassiManagement < XClarityBase

    BASE_URI = '/chassis'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      response = connection(BASE_URI)

      body = JSON.parse(response.body)
      body.map do |chassi|
        Chassi.new chassi
      end
    end

    def discover_chassis
      ChassiManagement.new(@connection).population
    end

    def get_object_chassis(uuids, includeAttributes, excludeAttributes)

      if not includeAttributes.nil?
        response = get_object_chassis_include_attributes(uuids, includeAttributes)
      elsif not excludeAttributes.nil?
        response = get_object_chassis_exclude_attributes(uuids, excludeAttributes)
      elsif not uuids.nil?
        response = connection(BASE_URI + "/" + uuids.join(","))
      else
        response = connection(BASE_URI)
      end


        body = JSON.parse(response.body) #rescue {}
        body.map do |chassi|
          Chassi.new chassi
        end
    end
    
    private

    def get_object_chassis_exclude_attributes(uuids, attributes)
      if not uuids.nil?
        response = connection(BASE_URI + "/#{uuids.join(",")}"+"?excludeAttributes=#{attributes.join(",")}")
      else
        response = connection(BASE_URI + "?excludeAttributes=" + attributes.join(","))
      end
    end

    def get_object_chassis_include_attributes(uuids, attributes)
      if not uuids.nil?
        response = connection(BASE_URI + "/" + uuids.join(",") + "?includeAttributes=" + attributes.join(","))
      else
        response = connection(BASE_URI + "?includeAttributes=" + attributes.join(","))
      end
    end

  end
end
