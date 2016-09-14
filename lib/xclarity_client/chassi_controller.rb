require 'json'

module XClarityClient
  class ChassiController < XClarityBase

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

    def get_object_chassis(uuids, includeAttributes, excludeAttributes)

      response = if not includeAttributes.nil?
                   get_object_chassis_include_attributes(uuids, includeAttributes)
                 elsif not excludeAttributes.nil?
                   get_object_chassis_exclude_attributes(uuids, excludeAttributes)
                 elsif not uuids.nil?
                   connection(BASE_URI + "/" + uuids.join(","))
                 else
                   connection(BASE_URI)
                 end


        puts "ALO ALO GRACAS  A DEUS: #{response.body.to_s}"
        body = JSON.parse(response.body)
        body.map do |chassi|
          Chassi.new chassi
        end
    end

    private

    def get_object_chassis_exclude_attributes(uuids, attributes)
      if not uuids.nil?
        response = connection(BASE_URI + "/" + uuids.join(",") + "?excludeAttributes=" + attributes.join(","))
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
