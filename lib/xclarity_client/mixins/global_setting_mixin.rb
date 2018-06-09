module XClarityClient
  #
  # Exposes GlobalSettingManagement features
  #
  module Mixins::GlobalSettingMixin
    def get_globalsettings
      GlobalSettingManagement.new(@config).fetch_all
    end

    def set_globalsettings(opts = {})
      GlobalSettingManagement.new(@config).set_globalsettings(opts)
    end
  end
end
