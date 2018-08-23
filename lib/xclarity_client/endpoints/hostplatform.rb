module XClarityClient
  class HostPlatform < Endpoints::XclarityEndpoint
    BASE_URI = '/hostPlatforms'.freeze
    LIST_NAME = 'items'.freeze

    attr_accessor :availableImages, :bay, :bootOrder, :chassisIpAddress,
                  :chassisName, :chassisuuid, :deployStatus, :deployStatusID,
                  :id, :immIpAddress, :isRealNode, :licenseKey, :mgmtProcType,
                  :name, :networkSettings, :nodeType, :primary, :rackID,
                  :rackUnit, :readyCheck, :remoteControl, :storageSettings,
                  :uuid
  end
end
