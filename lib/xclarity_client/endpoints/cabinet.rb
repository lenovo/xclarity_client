module XClarityClient
  class Cabinet < Endpoints::XclarityEndpoint
    BASE_URI = '/cabinet'.freeze
    LIST_NAME = 'cabinetList'.freeze

    attr_accessor :cabinetName, :chassisList, :complexList, :height, :location, :nodeList,
                  :placeholderList, :room, :storageList, :switchList, :UUID
  end
end
