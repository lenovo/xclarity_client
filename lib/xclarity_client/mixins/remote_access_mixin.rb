module XClarityClient
  #
  # Exposes RemoteAccessManagement features
  #
  module Mixins::RemoteAccessMixin
    def remote_control(uuid)
      RemoteAccessManagement.new(@config).remote_control(uuid)
    end
  end
end
