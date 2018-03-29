module XClarityClient
  class OsImage
    include XClarityClient::Resource

    BASE_URI = '/osImages'.freeze
    LIST_NAME = 'items'.freeze

    attr_accessor :description, :osrelease, :name, :profiles,
                  :id, :type, :osBuildId, :deployStatus

    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
