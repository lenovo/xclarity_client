module XClarityClient
  class Chassi
    BASE_URI = '/chassis'.freeze

    attr_accessor

    def initialize(attributes)
    end

    def build_chassi(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end
  end
end
