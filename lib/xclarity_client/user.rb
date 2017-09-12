module XClarityClient
  class User
    include XClarityClient::Resource

    BASE_URI = '/userAccounts'.freeze
    LIST_NAME = 'usersList'.freeze

    attr_accessor :response, :PasswordChangeFirstAccess, :activeSessions, :createTimestamp, :description, :groups,
    :id, :lastLoginTimestamp, :ldapDn, :loginAttempts, :loginCount, :modifyTimestamp, :pwExpirationWarning, 
    :pwExpired, :pwdAge, :reserved, :state, :supervisor, :timeBeforeExpirationInDays, :userName, :userPw,
    :result, :messages
    
    def initialize(attributes)
      build_resource(attributes)
    end

  end
end
