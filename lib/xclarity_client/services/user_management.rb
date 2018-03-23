require 'json'

module XClarityClient
  class UserManagement < XClarityBase

    include XClarityClient::ManagementMixin

    def initialize(conf)
      super(conf, User::BASE_URI)
    end

    def population()
      get_all_resources(User)
    end

    def change_password(current_password, new_password)
      payload = {
        password: current_password,
        newPassword: new_password,
        confirmPassword: new_password
      }

      request_body = JSON.generate(payload)

      response = do_put(User::SUB_URIS[:changePassword], request_body)

      mount_response_change_password(response)
    end

    private

    # Mounts a friendly response for the change password request
    #
    # @param [response] response provided by LXCA in change password endpoint
    # @return [Hash] represents LXCA response
    #   :changed [Boolean] says if the password was changed or not
    #   :message [String] message from LXCA about the operation
    def mount_response_change_password(response)
      response = JSON.parse(response.body)

      {
        changed: response['response']['changed'],
        message: response['messages'].first['explanation']
      }
    end
  end
end
