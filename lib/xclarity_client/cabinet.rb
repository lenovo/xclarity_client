module XClarityClient
  class Cabinet
    include XClarityClient::Resource

    BASE_URI = '/cabinet'.freeze

    attr_accessor :cabinetName, :chassisList, :complexList, :height, :location, :nodeList,
                  :placeholderList, :room, :storageList, :switchList, :UUID

    def initialize(attributes)
      build_resource(attributes)
    end
  end
end
