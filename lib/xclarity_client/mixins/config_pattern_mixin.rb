module XClarityClient
  #
  # Exposes ConfigPatternManagement features
  #
  module Mixins::ConfigPatternMixin
    def fetch_config_pattern(ids = nil,
                             include_attributes = nil,
                             exclude_attributes = nil)
      ConfigPatternManagement.new(@config).get_object_with_id(
        ids,
        include_attributes,
        exclude_attributes
      )
    end

    def discover_config_pattern
      ConfigPatternManagement.new(@config).fetch_all
    end

    def export_config_pattern(id = '')
      ConfigPatternManagement.new(@config).export(id)
    end

    def deploy_config_pattern(id = '',
                              endpoints = nil,
                              restart = '',
                              etype = '')
      ConfigPatternManagement.new(@config).deploy_config_pattern(
        id,
        endpoints,
        restart,
        etype
      )
    end

    def import_config_pattern(config_pattern = {})
      ConfigPatternManagement.new(@config).import_config_pattern(config_pattern)
    end
  end
end
