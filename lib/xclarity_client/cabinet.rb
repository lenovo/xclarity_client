module XClarityClient
  class Cabinet

    BASE_URI = '/cabinet'.freeze

    attr_accessor :cabinetName, :chassisList, :complexList, :height, :location, :nodeList,
                  :placeholderList, :room, :storageList, :switchList, :UUID

    def initialize(attributes)
      build_cabinet(attributes)
    end

    def build_cabinet(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

  end
end
