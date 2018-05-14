module XClarityClient
  #
  # Facade that exposes the lib features
  #
  class Client
    include XClarityClient::Mixins::AiccMixin
    include XClarityClient::Mixins::CabinetMixin
    include XClarityClient::Mixins::CanisterMixin
    include XClarityClient::Mixins::ChassiMixin
    include XClarityClient::Mixins::CmmMixin
    include XClarityClient::Mixins::CompliancePolicyMixin
    include XClarityClient::Mixins::ConfigPatternMixin
    include XClarityClient::Mixins::ConfigProfileMixin
    include XClarityClient::Mixins::ConfigTargetMixin
    include XClarityClient::Mixins::DiscoverMixin
    include XClarityClient::Mixins::DiscoverRequestMixin
    include XClarityClient::Mixins::EventMixin
    include XClarityClient::Mixins::FanMixin
    include XClarityClient::Mixins::FanMuxMixin
    include XClarityClient::Mixins::FfdcMixin
    include XClarityClient::Mixins::GlobalSettingMixin
    include XClarityClient::Mixins::HostPlatformMixin
    include XClarityClient::Mixins::JobMixin
    include XClarityClient::Mixins::NodeMixin
    include XClarityClient::Mixins::OsImageMixin
    include XClarityClient::Mixins::PersistedResultMixin
    include XClarityClient::Mixins::PowerSupplyMixin
    include XClarityClient::Mixins::RemoteAccessMixin
    include XClarityClient::Mixins::RemoteFileServerMixin
    include XClarityClient::Mixins::ScalableComplexMixin
    include XClarityClient::Mixins::StorageMixin
    include XClarityClient::Mixins::SwitchMixin
    include XClarityClient::Mixins::UnmanageRequestMixin
    include XClarityClient::Mixins::UpdateRepoMixin
    include XClarityClient::Mixins::UserMixin

    def initialize(config)
      @config = config
    end

    def validate_configuration
      XClarityCredentialsValidator.new(@config).validate
    end
  end
end
