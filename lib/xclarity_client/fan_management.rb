require 'json'

module XClarityClient
  class FanManagement < XClarityBase

    BASE_URI = '/fans'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      response = connection(BASE_URI)


      body = JSON.parse(response.body)
      body.map do |fan|
        Fan.new fan
      end
    end

    def get_object_fans(uuids, includeAttributes, excludeAttributes)

      response = if not includeAttributes.nil?
                  get_object_fans_include_attributes(uuids, includeAttributes)
                elsif not excludeAttributes.nil?
                  get_object_fans_exclude_attributes(uuids, excludeAttributes)
                elsif not uuids.nil?
                  response = connection(BASE_URI + "/" + uuids)
                  body = JSON.parse(response.body)
                  Fan.new body
                else
                  response = connection(BASE_URI)
                  body = JSON.parse(response.body)
                  body.map do |fan|
                    Fan.new fan
                  end
                end
    end

    def get_object_fans_exclude_attributes(uuids, attributes)

      response = if not uuids.nil?
                  response = connection(BASE_URI + "/" + uuids + "?excludeAttributes="+ attributes.join(","))
                  body = JSON.parse(response.body)
                  Fan.new body
                else
                  response = connection(BASE_URI + "?excludeAttributes=" + attributes.join(","))
                  body = JSON.parse(response.body)
                  body.map do |fan|
                    Fan.new fan
                  end
                end
    end

    def get_object_fans_include_attributes(uuids, attributes)
      response = if not uuids.nil?
                  response = connection(BASE_URI + "/" + uuids + "?includeAttributes="+ attributes.join(","))
                  body = JSON.parse(response.body)
                  Fan.new body
                else
                  response = connection(BASE_URI + "?includeAttributes=" + attributes.join(","))
                  body = JSON.parse(response.body)
                  body.map do |fan|
                    Fan.new fan
                  end
                end
    end
  end
end
