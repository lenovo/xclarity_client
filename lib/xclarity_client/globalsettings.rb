module XClarityClient
  class GlobalSetting
    include XClarityClient::Resource

    BASE_URI = '/osdeployment/globalSettings'.freeze

    attr_accessor :activeDirectory, :credentials, :ipAssignment,
                  :isVLANMode, :licenseKeys

    def initialize(attributes)
      build_resource(attributes)
    end
  end
end
