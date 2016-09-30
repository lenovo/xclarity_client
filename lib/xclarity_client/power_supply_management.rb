require 'json'

module XClarityClient
  class PowerSupplyManagement < XClarityBase
    BASE_URI = '/powerSupplies'.freeze

    def initialize(conf)
      super(conf, BASE_URI)
    end

    def population
      response = connection(BASE_URI)

      body = JSON.parse(response.body)
      body['powerSupplyList'].map do |power_supply|
        PowerSupply.new power_supply
      end
    end

    def get_object_power_supplies(uuids, includeAttributes, excludeAttributes)
      if not includeAttributes.nil?
        response = get_object_power_supplies_include_attributes(uuids, includeAttributes)
      elsif not excludeAttributes.nil?
        response = get_object_power_supplies_exclude_attributes(uuids, excludeAttributes)
      elsif not uuids.nil?
        response = connection(BASE_URI + "/" + uuids.join(","))
        body = JSON.parse(response.body)
        PowerSupply.new body
      else
        response = connection(BASE_URI)
        body = JSON.parse(response.body)
        PowerSupply.new body
      end
    end

    def get_object_power_supplies_exclude_attributes(uuids, attributes)
      response = nil
      if not uuids.nil?
        response = connection(BASE_URI + "/" + uuids.join(",") + "?excludeAttributes="+ attributes.join(","))
        body = JSON.parse(response.body)
        PowerSupply.new body
      else
        response = connection(BASE_URI + "?excludeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        body['powerSupplyList'].map do |power_supply|
          PowerSupply.new power_supply
        end
      end
    end

    def get_object_power_supplies_include_attributes(uuids, attributes)
      response = nil
      if not uuids.nil?
        response = connection(BASE_URI + "/" + uuids.join(",") + "?includeAttributes="+ attributes.join(","))
        body = JSON.parse(response.body)
        PowerSupply.new body
      else
        response = connection(BASE_URI + "?includeAttributes=" + attributes.join(","))
        body = JSON.parse(response.body)
        body['powerSupplyList'].map do |power_supply|
          PowerSupply.new power_supply
        end
      end
    end
  end
end
