module XClarityClient
  #
  # Exposes CompliancePolicyManagement features
  #
  module Mixins::CompliancePolicyMixin
    def discover_update_policy(opts = {})
      CompliancePolicyManagement.new(@config).fetch_all(opts)
    end

    def discover_application_firmware
      CompliancePolicyManagement.new(@config).get_applicable_firmware
    end

    def discover_persisted_compare_results(opts = {})
      CompliancePolicyManagement.new(@config).get_persisted_compare_results(
        opts
      )
    end

    def discover_compare_results(opts = {})
      CompliancePolicyManagement.new(@config).get_compare_results(
        opts
      )
    end

    def assign_compliance_policy(opts = {}, keep = nil, auto_assign = nil)
      CompliancePolicyManagement.new(@config).assign_compliance_policy(
        opts, keep, auto_assign
      )
    end

    def delete_compliance_policy(policy_name, remove_package = nil)
      CompliancePolicyManagement.new(@config).delete_compliance_policy(
        policy_name, remove_package
      )
    end
  end
end
