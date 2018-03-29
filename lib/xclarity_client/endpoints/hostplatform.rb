module XClarityClient
  class HostPlatform
    include XClarityClient::Resource

    BASE_URI = '/hostPlatforms'.freeze
    LIST_NAME = 'items'.freeze

    attr_accessor :availableImages, :bay, :bootOrder, :chassisIpAddress,
                  :chassisName, :chassisuuid, :deployStatus, :deployStatusID,
                  :id, :immIpAddress, :isRealNode, :licenseKey, :mgmtProcType,
                  :name, :networkSettings, :nodeType, :primary, :rackID,
                  :rackUnit, :readyCheck, :remoteControl, :storageSettings,
                  :uuid

    def initialize(attributes)
      build_resource(attributes)
    end
  end
end
