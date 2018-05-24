module XClarityClient
  class GlobalSetting < Endpoints::XclarityEndpoint
    BASE_URI = '/osdeployment/globalSettings'.freeze

    attr_accessor :activeDirectory, :credentials, :ipAssignment,
                  :isVLANMode, :licenseKeys

  end
end
