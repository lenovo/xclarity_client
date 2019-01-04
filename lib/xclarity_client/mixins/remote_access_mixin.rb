module XClarityClient
  #
  # Exposes RemoteAccessManagement features
  #
  module Mixins::RemoteAccessMixin
    def remote_control(uuid)
      res = fetch_nodes([uuid])
      tier_level = res[0].FeaturesOnDemand['tierLevel']

      if tier_level == -1
        raise ['Cannot launch remote console because tier level value is',
               ' invalid.Please contact the administrator.'].join
      end

      RemoteAccessManagement.new(@config).remote_control(uuid)
    end
  end
end
