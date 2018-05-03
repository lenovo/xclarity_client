module XClarityClient
  #
  # Exposes UserManagement features
  #
  module Mixins::UserMixin
    def discover_users(_opts = {})
      UserManagement.new(@config).fetch_all
    end

    def fetch_users(ids = nil,
                    include_attributes = nil,
                    exclude_attributes = nil)
      UserManagement.new(@config).get_object_with_id(
        ids,
        include_attributes,
        exclude_attributes
      )
    end

    def change_user_password(current_password, new_password)
      UserManagement.new(@config).change_password(
        current_password, new_password
      )
    end
  end
end
