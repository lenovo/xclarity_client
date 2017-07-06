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

  end
end
