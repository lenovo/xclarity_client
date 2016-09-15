module XClarityClient
  class PowerSupply
    BASE_URI = '/power_supplies'.freeze

    attr_accessor
    # TODO insert power supplies attributes for LXCA-MockUp/spec/factories/power_supply_properties

    def initialize(attributes)
      build_chassi(attributes)
    end

    def build_chassi(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end
  end
end
