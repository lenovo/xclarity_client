require 'json'

module XClarityClient
  class FanMuxManagement < XClarityBase

    BASE_URI = '/fanMuxes'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      response = connection(BASE_URI)

      body = JSON.parse(response.body)
      body = {'fanMuxList' => [body]} unless body.has_key? 'fanMuxList'
      body['fanMuxList'].map do |fan_mux|
        FanMux.new fan_mux
      end
    end

    def get_object_fan_muxes(uuids, includeAttributes, excludeAttributes)

      response = if not includeAttributes.nil?
                  get_object_fan_muxes_include_attributes(uuids, includeAttributes)
                elsif not excludeAttributes.nil?
                  get_object_fan_muxes_exclude_attributes(uuids, excludeAttributes)
                elsif not uuids.nil?
                  response = connection(BASE_URI + "/" + uuids.join(","))
                  fan_mux = JSON.parse(response.body)
                  FanMux.new fan_mux
                else
                  response = connection(BASE_URI)
                  fan_mux = JSON.parse(response.body)
                  FanMux.new fan_mux
                end
    end

    def get_object_fan_muxes_exclude_attributes(uuids, attributes)

      response = if not uuids.nil?
              response =  connection(BASE_URI + "/" + uuids.join(",") + "?excludeAttributes="+ attributes.join(","))
                          fan_mux = JSON.parse(response.body)
                          FanMux.new fan_mux
                else
              response =  connection(BASE_URI + "?excludeAttributes=" + attributes.join(","))
                          body = JSON.parse(response.body)
                          body = {'fanMuxList' => [body]} unless body.has_key? 'fanMuxList'
                          body['fanMuxList'].map do |fan_mux|
                            FanMux.new fan_mux
                          end
                end
    end

    def get_object_fan_muxes_include_attributes(uuids, attributes)
      if not uuids.nil?
        response = connection(BASE_URI + "/" + uuids.join(",") + "?includeAttributes="+ attributes.join(","))
        fan_mux = JSON.parse(response.body)
        FanMux.new fan_mux
      else
        response = connection(BASE_URI + "?includeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        body = {'fanMuxList' => [body]} unless body.has_key? 'fanMuxList'
        body['fanMuxList'].map do |fan_mux|
          FanMux.new fan_mux
        end
      end
    end
  end
end
