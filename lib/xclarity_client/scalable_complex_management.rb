require 'json'

module XClarityClient
  class ScalableComplexManagement < XClarityBase

    BASE_URI = '/scalableComplex'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      response = connection(BASE_URI)
      body = JSON.parse(response.body)
      body = {'complex' => [body]} unless body.has_key? 'complex'
      body['complex'].map do |scalableComplex|
        ScalableComplex.new scalableComplex
      end
    end

    def get_object_scalableComplexes(uuids, includeAttributes, excludeAttributes)

      response = if not includeAttributes.nil?
        get_object_scalableComplexes_include_attributes(uuids, includeAttributes)
      elsif not excludeAttributes.nil?
        get_object_scalableComplexes_exclude_attributes(uuids, excludeAttributes)
      elsif not uuids.nil?
        response = connection(BASE_URI + "/" + uuids)
        body = JSON.parse(response.body)
        body = {'complex' => [body]} unless body.has_key? 'complex'
        body['complex'].map do |scalableComplex|
          ScalableComplex.new scalableComplex
        end
      else
        response = connection(BASE_URI)
        body = JSON.parse(response.body)
        body = {'complex' => [body]} unless body.has_key? 'complex'
        body['complex'].map do |scalableComplex|
          ScalableComplex.new scalableComplex
        end
      end

    end

    def get_object_scalableComplexes_exclude_attributes(uuids, attributes)

      if not uuids.nil?
        response = connection(BASE_URI + "/" + uuids +"?excludeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        body = {'complex' => [body]} unless body.has_key? 'complex'
        body['complex'].map do |scalableComplex|
          ScalableComplex.new scalableComplex
        end
      else
        response = connection(BASE_URI + "?excludeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        body = {'complex' => [body]} unless body.has_key? 'complex'
        body['complex'].map do |scalableComplex|
          ScalableComplex.new scalableComplex
        end
      end

    end

    def get_object_scalableComplexes_include_attributes(uuids, attributes)
      if not uuids.nil?
        response =  connection(BASE_URI + "/" + uuids + "?includeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        body = {'complex' => [body]} unless body.has_key? 'complex'
        body['complex'].map do |scalableComplex|
          ScalableComplex.new scalableComplex
        end
      else
        response = connection(BASE_URI + "?includeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        body = {'complex' => [body]} unless body.has_key? 'complex'
        body['complex'].map do |scalableComplex|
          ScalableComplex.new scalableComplex
        end
      end
    end
  end
end
